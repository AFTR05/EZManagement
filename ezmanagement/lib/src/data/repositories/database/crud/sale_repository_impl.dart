import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/core/exceptions/sale_exception.dart';
import 'package:ezmanagement/src/domain/entities/sale_entity.dart';
import 'package:ezmanagement/src/domain/enum/payment_method_enum.dart';
import 'package:ezmanagement/src/domain/repositories/crud/sale_repository.dart';

class SaleRepositoryImpl extends SaleRepository {
  SaleRepositoryImpl({
    FirebaseFirestore? firestore,
    String collectionPath = 'sales',
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _collection =
            (firestore ?? FirebaseFirestore.instance).collection(collectionPath);

  final FirebaseFirestore _firestore;
  final CollectionReference<Map<String, dynamic>> _collection;

  Map<String, dynamic> _normalize(Map<String, dynamic> data) {
    final normalized = Map<String, dynamic>.from(data);

    // saleDate puede venir como Timestamp/DateTime/String
    final rawDate = normalized['saleDate'];
    if (rawDate is Timestamp) {
      normalized['saleDate'] = rawDate.toDate().toIso8601String();
    } else if (rawDate is DateTime) {
      normalized['saleDate'] = rawDate.toIso8601String();
    } else if (rawDate is String) {
      // ya está OK para el fromMap actual
    } else {
      normalized['saleDate'] = DateTime.now().toIso8601String();
    }

    // paymentMethod puede venir en minúsculas/mayúsculas
    final pm = normalized['paymentMethod'];
    if (pm is String) {
      final value = pm.trim();
      final match = PaymentMethodEnum.values.firstWhere(
        (e) => e.toString().split('.').last.toLowerCase() == value.toLowerCase(),
        orElse: () => PaymentMethodEnum.cash,
      );
      normalized['paymentMethod'] = match.toString().split('.').last;
    }

    return normalized;
  }

  @override
  Future<Either<Failure, List<SaleEntity>>> getAllElements() async {
    try {
      final snap = await _collection.get();
      final items = snap.docs
          .map((d) => SaleEntity.fromMap(_normalize(d.data()), d.id))
          .toList();
      return Right(items);
    } catch (_) {
      return Left(SaleException());
    }
  }

  @override
  Future<Either<Failure, SaleEntity>> getElementById({
    required String id,
  }) async {
    try {
      final doc = await _collection.doc(id).get();
      if (!doc.exists) return Left(SaleException());
      return Right(SaleEntity.fromMap(_normalize(doc.data()!), doc.id));
    } catch (_) {
      return Left(SaleException());
    }
  }

  @override
  Future<Either<Failure, SaleEntity>> createElement({
    required SaleEntity t,
  }) async {
    try {
      final docRef = t.id.isEmpty ? _collection.doc() : _collection.doc(t.id);
      final newEntity =
          t.id.isEmpty ? SaleEntity.fromMap(t.toMap(), docRef.id) : t;

      await docRef.set(newEntity.toMap(), SetOptions(merge: false));
      return Right(newEntity);
    } catch (_) {
      return Left(SaleException());
    }
  }

  @override
  Future<Either<Failure, List<SaleEntity>>> createElements({
    required List<SaleEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      final created = <SaleEntity>[];

      for (final s in ts) {
        final docRef = s.id.isEmpty ? _collection.doc() : _collection.doc(s.id);
        final newEntity =
            s.id.isEmpty ? SaleEntity.fromMap(s.toMap(), docRef.id) : s;

        batch.set(docRef, newEntity.toMap(), SetOptions(merge: false));
        created.add(newEntity);
      }

      await batch.commit();
      return Right(created);
    } catch (_) {
      return Left(SaleException());
    }
  }

  @override
  Future<Either<Failure, SaleEntity>> updateElement({
    required SaleEntity t,
  }) async {
    try {
      await _collection.doc(t.id).update(t.toMap());
      return Right(t);
    } catch (_) {
      return Left(SaleException());
    }
  }

  @override
  Future<Either<Failure, List<SaleEntity>>> updateElements({
    required List<SaleEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      for (final s in ts) {
        batch.update(_collection.doc(s.id), s.toMap());
      }
      await batch.commit();
      return Right(ts);
    } catch (_) {
      return Left(SaleException());
    }
  }

  @override
  Future<Either<Failure, SaleEntity>> deleteElement({
    required SaleEntity t,
  }) async {
    try {
      await _collection.doc(t.id).delete();
      return Right(t);
    } catch (_) {
      return Left(SaleException());
    }
  }

  @override
  Future<Either<Failure, List<SaleEntity>>> deleteElements({
    required List<SaleEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      for (final s in ts) {
        batch.delete(_collection.doc(s.id));
      }
      await batch.commit();
      return Right(ts);
    } catch (_) {
      return Left(SaleException());
    }
  }
}
