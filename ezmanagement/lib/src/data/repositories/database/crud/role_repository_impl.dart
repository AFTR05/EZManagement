import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/core/exceptions/role_exception.dart';
import 'package:ezmanagement/src/domain/entities/role_entity.dart';
import 'package:ezmanagement/src/domain/repositories/crud/role_repository.dart';

class RoleRepositoryImpl extends RoleRepository {
  RoleRepositoryImpl({
    FirebaseFirestore? firestore,
    String collectionPath = 'roles',
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _collection =
            (firestore ?? FirebaseFirestore.instance).collection(collectionPath);

  final FirebaseFirestore _firestore;
  final CollectionReference<Map<String, dynamic>> _collection;

  @override
  Future<Either<Failure, List<RoleEntity>>> getAllElements() async {
    try {
      final snap = await _collection.get();
      final items =
          snap.docs.map((d) => RoleEntity.fromMap(d.data(), d.id)).toList();
      return Right(items);
    } catch (_) {
      return Left(RoleException());
    }
  }

  @override
  Future<Either<Failure, RoleEntity>> getElementById({
    required String id,
  }) async {
    try {
      final doc = await _collection.doc(id).get();
      if (!doc.exists) return Left(RoleException());
      return Right(RoleEntity.fromMap(doc.data()!, doc.id));
    } catch (_) {
      return Left(RoleException());
    }
  }

  @override
  Future<Either<Failure, RoleEntity>> createElement({
    required RoleEntity t,
  }) async {
    try {
      final docRef = t.id.isEmpty ? _collection.doc() : _collection.doc(t.id);

      final newEntity =
          t.id.isEmpty ? RoleEntity.fromMap(t.toMap(), docRef.id) : t;

      await docRef.set(newEntity.toMap(), SetOptions(merge: false));
      return Right(newEntity);
    } catch (_) {
      return Left(RoleException());
    }
  }

  @override
  Future<Either<Failure, List<RoleEntity>>> createElements({
    required List<RoleEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      final created = <RoleEntity>[];

      for (final r in ts) {
        final docRef = r.id.isEmpty ? _collection.doc() : _collection.doc(r.id);
        final newEntity =
            r.id.isEmpty ? RoleEntity.fromMap(r.toMap(), docRef.id) : r;

        batch.set(docRef, newEntity.toMap(), SetOptions(merge: false));
        created.add(newEntity);
      }

      await batch.commit();
      return Right(created);
    } catch (_) {
      return Left(RoleException());
    }
  }

  @override
  Future<Either<Failure, RoleEntity>> updateElement({
    required RoleEntity t,
  }) async {
    try {
      await _collection.doc(t.id).update(t.toMap());
      return Right(t);
    } catch (_) {
      return Left(RoleException());
    }
  }

  @override
  Future<Either<Failure, List<RoleEntity>>> updateElements({
    required List<RoleEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      for (final r in ts) {
        batch.update(_collection.doc(r.id), r.toMap());
      }
      await batch.commit();
      return Right(ts);
    } catch (_) {
      return Left(RoleException());
    }
  }

  @override
  Future<Either<Failure, RoleEntity>> deleteElement({
    required RoleEntity t,
  }) async {
    try {
      await _collection.doc(t.id).delete();
      return Right(t);
    } catch (_) {
      return Left(RoleException());
    }
  }

  @override
  Future<Either<Failure, List<RoleEntity>>> deleteElements({
    required List<RoleEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      for (final r in ts) {
        batch.delete(_collection.doc(r.id));
      }
      await batch.commit();
      return Right(ts);
    } catch (_) {
      return Left(RoleException());
    }
  }
}
