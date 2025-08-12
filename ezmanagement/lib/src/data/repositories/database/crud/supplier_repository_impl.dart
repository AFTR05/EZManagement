import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/core/exceptions/supplier_exception.dart';
import 'package:ezmanagement/src/domain/entities/supplier_entity.dart';
import 'package:ezmanagement/src/domain/repositories/crud/supplier_repository.dart';

class SupplierRepositoryImpl extends SupplierRepository {
  SupplierRepositoryImpl({
    FirebaseFirestore? firestore,
    String collectionPath = 'suppliers',
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _collection =
            (firestore ?? FirebaseFirestore.instance).collection(collectionPath);

  final FirebaseFirestore _firestore;
  final CollectionReference<Map<String, dynamic>> _collection;

  @override
  Future<Either<Failure, List<SupplierEntity>>> getAllElements() async {
    try {
      final snap = await _collection.get();
      final items =
          snap.docs.map((d) => SupplierEntity.fromMap(d.data(), d.id)).toList();
      return Right(items);
    } catch (_) {
      return Left(SupplierException());
    }
  }

  @override
  Future<Either<Failure, SupplierEntity>> getElementById({
    required String id,
  }) async {
    try {
      final doc = await _collection.doc(id).get();
      if (!doc.exists) return Left(SupplierException());
      return Right(SupplierEntity.fromMap(doc.data()!, doc.id));
    } catch (_) {
      return Left(SupplierException());
    }
  }

  @override
  Future<Either<Failure, SupplierEntity>> createElement({
    required SupplierEntity t,
  }) async {
    try {
      final docRef = t.id.isEmpty ? _collection.doc() : _collection.doc(t.id);
      final newEntity =
          t.id.isEmpty ? SupplierEntity.fromMap(t.toMap(), docRef.id) : t;

      await docRef.set(newEntity.toMap(), SetOptions(merge: false));
      return Right(newEntity);
    } catch (_) {
      return Left(SupplierException());
    }
  }

  @override
  Future<Either<Failure, List<SupplierEntity>>> createElements({
    required List<SupplierEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      final created = <SupplierEntity>[];

      for (final s in ts) {
        final docRef = s.id.isEmpty ? _collection.doc() : _collection.doc(s.id);
        final newEntity =
            s.id.isEmpty ? SupplierEntity.fromMap(s.toMap(), docRef.id) : s;

        batch.set(docRef, newEntity.toMap(), SetOptions(merge: false));
        created.add(newEntity);
      }

      await batch.commit();
      return Right(created);
    } catch (_) {
      return Left(SupplierException());
    }
  }

  @override
  Future<Either<Failure, SupplierEntity>> updateElement({
    required SupplierEntity t,
  }) async {
    try {
      await _collection.doc(t.id).update(t.toMap());
      return Right(t);
    } catch (_) {
      return Left(SupplierException());
    }
  }

  @override
  Future<Either<Failure, List<SupplierEntity>>> updateElements({
    required List<SupplierEntity> ts,
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
      return Left(SupplierException());
    }
  }

  @override
  Future<Either<Failure, SupplierEntity>> deleteElement({
    required SupplierEntity t,
  }) async {
    try {
      await _collection.doc(t.id).delete();
      return Right(t);
    } catch (_) {
      return Left(SupplierException());
    }
  }

  @override
  Future<Either<Failure, List<SupplierEntity>>> deleteElements({
    required List<SupplierEntity> ts,
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
      return Left(SupplierException());
    }
  }
}
