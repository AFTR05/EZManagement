import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/core/exceptions/monetary_income_exception.dart';
import 'package:ezmanagement/src/domain/entities/monetary_income_entity.dart';
import 'package:ezmanagement/src/domain/repositories/crud/monetary_income_repository.dart';

class MonetaryIncomeRepositoryImpl extends MonetaryIncomeRepository {
  MonetaryIncomeRepositoryImpl({
    FirebaseFirestore? firestore,
    String collectionPath = 'monetary_incomes',
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _collection =
            (firestore ?? FirebaseFirestore.instance).collection(collectionPath);

  final FirebaseFirestore _firestore;
  final CollectionReference<Map<String, dynamic>> _collection;

  @override
  Future<Either<Failure, List<MonetaryIncomeEntity>>> getAllElements() async {
    try {
      final snap = await _collection.get();
      final items = snap.docs
          .map((d) => MonetaryIncomeEntity.fromMap(d.data(), d.id))
          .toList();
      return Right(items);
    } catch (_) {
      return Left(MonetaryIncomeException());
    }
  }

  @override
  Future<Either<Failure, MonetaryIncomeEntity>> getElementById({
    required String id,
  }) async {
    try {
      final doc = await _collection.doc(id).get();
      if (!doc.exists) return Left(MonetaryIncomeException());
      return Right(MonetaryIncomeEntity.fromMap(doc.data()!, doc.id));
    } catch (_) {
      return Left(MonetaryIncomeException());
    }
  }

  @override
  Future<Either<Failure, MonetaryIncomeEntity>> createElement({
    required MonetaryIncomeEntity t,
  }) async {
    try {
      final docRef = t.id.isEmpty ? _collection.doc() : _collection.doc(t.id);

      // Si tu entidad tiene copyWith({id}), puedes usarlo aquí.
      final newEntity = t.id.isEmpty
          ? MonetaryIncomeEntity.fromMap(t.toMap(), docRef.id)
          : t;

      await docRef.set(newEntity.toMap(), SetOptions(merge: false));
      return Right(newEntity);
    } catch (_) {
      return Left(MonetaryIncomeException());
    }
  }

  @override
  Future<Either<Failure, List<MonetaryIncomeEntity>>> createElements({
    required List<MonetaryIncomeEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      final created = <MonetaryIncomeEntity>[];

      for (final m in ts) {
        final docRef = m.id.isEmpty ? _collection.doc() : _collection.doc(m.id);
        final newEntity = m.id.isEmpty
            ? MonetaryIncomeEntity.fromMap(m.toMap(), docRef.id)
            : m;

        batch.set(docRef, newEntity.toMap(), SetOptions(merge: false));
        created.add(newEntity);
      }

      await batch.commit();
      return Right(created);
    } catch (_) {
      return Left(MonetaryIncomeException());
    }
  }

  @override
  Future<Either<Failure, MonetaryIncomeEntity>> updateElement({
    required MonetaryIncomeEntity t,
  }) async {
    try {
      await _collection.doc(t.id).update(t.toMap());
      return Right(t);
    } catch (_) {
      return Left(MonetaryIncomeException());
    }
  }

  @override
  Future<Either<Failure, List<MonetaryIncomeEntity>>> updateElements({
    required List<MonetaryIncomeEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      for (final m in ts) {
        batch.update(_collection.doc(m.id), m.toMap());
      }
      await batch.commit();
      return Right(ts);
    } catch (_) {
      return Left(MonetaryIncomeException());
    }
  }

  @override
  Future<Either<Failure, MonetaryIncomeEntity>> deleteElement({
    required MonetaryIncomeEntity t,
  }) async {
    try {
      await _collection.doc(t.id).delete();
      return Right(t);
    } catch (_) {
      return Left(MonetaryIncomeException());
    }
  }

  @override
  Future<Either<Failure, List<MonetaryIncomeEntity>>> deleteElements({
    required List<MonetaryIncomeEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      for (final m in ts) {
        batch.delete(_collection.doc(m.id));
      }
      await batch.commit();
      return Right(ts);
    } catch (_) {
      return Left(MonetaryIncomeException());
    }
  }
}
