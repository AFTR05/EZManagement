import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/core/exceptions/permission_exception.dart';
import 'package:ezmanagement/src/domain/entities/permission_entity.dart';
import 'package:ezmanagement/src/domain/repositories/crud/permission_repository.dart';

class PermissionRepositoryImpl extends PermissionRepository {
  PermissionRepositoryImpl({
    FirebaseFirestore? firestore,
    String collectionPath = 'permissions',
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _collection =
            (firestore ?? FirebaseFirestore.instance).collection(collectionPath);

  final FirebaseFirestore _firestore;
  final CollectionReference<Map<String, dynamic>> _collection;

  @override
  Future<Either<Failure, List<PermissionEntity>>> getAllElements() async {
    try {
      final snap = await _collection.get();
      final items = snap.docs
          .map((d) => PermissionEntity.fromMap(d.data(), d.id))
          .toList();
      return Right(items);
    } catch (_) {
      return Left(PermissionException());
    }
  }

  @override
  Future<Either<Failure, PermissionEntity>> getElementById({
    required String id,
  }) async {
    try {
      final doc = await _collection.doc(id).get();
      if (!doc.exists) return Left(PermissionException());
      return Right(PermissionEntity.fromMap(doc.data()!, doc.id));
    } catch (_) {
      return Left(PermissionException());
    }
  }

  @override
  Future<Either<Failure, PermissionEntity>> createElement({
    required PermissionEntity t,
  }) async {
    try {
      final docRef = t.id.isEmpty ? _collection.doc() : _collection.doc(t.id);

      final newEntity =
          t.id.isEmpty ? PermissionEntity.fromMap(t.toMap(), docRef.id) : t;

      await docRef.set(newEntity.toMap(), SetOptions(merge: false));
      return Right(newEntity);
    } catch (_) {
      return Left(PermissionException());
    }
  }

  @override
  Future<Either<Failure, List<PermissionEntity>>> createElements({
    required List<PermissionEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      final created = <PermissionEntity>[];

      for (final p in ts) {
        final docRef = p.id.isEmpty ? _collection.doc() : _collection.doc(p.id);
        final newEntity =
            p.id.isEmpty ? PermissionEntity.fromMap(p.toMap(), docRef.id) : p;

        batch.set(docRef, newEntity.toMap(), SetOptions(merge: false));
        created.add(newEntity);
      }

      await batch.commit();
      return Right(created);
    } catch (_) {
      return Left(PermissionException());
    }
  }

  @override
  Future<Either<Failure, PermissionEntity>> updateElement({
    required PermissionEntity t,
  }) async {
    try {
      await _collection.doc(t.id).update(t.toMap());
      return Right(t);
    } catch (_) {
      return Left(PermissionException());
    }
  }

  @override
  Future<Either<Failure, List<PermissionEntity>>> updateElements({
    required List<PermissionEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      for (final p in ts) {
        batch.update(_collection.doc(p.id), p.toMap());
      }
      await batch.commit();
      return Right(ts);
    } catch (_) {
      return Left(PermissionException());
    }
  }

  @override
  Future<Either<Failure, PermissionEntity>> deleteElement({
    required PermissionEntity t,
  }) async {
    try {
      await _collection.doc(t.id).delete();
      return Right(t);
    } catch (_) {
      return Left(PermissionException());
    }
  }

  @override
  Future<Either<Failure, List<PermissionEntity>>> deleteElements({
    required List<PermissionEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      for (final p in ts) {
        batch.delete(_collection.doc(p.id));
      }
      await batch.commit();
      return Right(ts);
    } catch (_) {
      return Left(PermissionException());
    }
  }
}
