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
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _collection = (firestore ?? FirebaseFirestore.instance).collection(
         collectionPath,
       );

  final FirebaseFirestore _firestore;
  final CollectionReference<Map<String, dynamic>> _collection;

  @override
  Future<Either<Failure, List<RoleEntity>>> getAllElements() async {
    try {
      final snap = await _collection.get();
      final items = snap.docs
          .map((d) => RoleEntity.fromMap(d.data(), d.id))
          .toList();
      return Right(items);
    } on FirebaseException catch (_) {
      return Left(RoleException());
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
    } on FirebaseException catch (_) {
      return Left(RoleException());
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
      final safePermissions = List<String>.from(t.permissions);

      final newEntity = RoleEntity(
        id: t.id.isEmpty ? docRef.id : t.id,
        roleName: t.roleName.trim(),
        description: t.description.trim(),
        permissions: safePermissions,
      );

      await docRef.set(newEntity.toMap(), SetOptions(merge: false));
      return Right(newEntity);
    } on FirebaseException catch (_) {
      return Left(RoleException());
    } catch (_) {
      return Left(RoleException());
    }
  }

  @override
  Stream<Either<Failure, List<RoleEntity>>> watchAllElements() async* {
    try {
      final snapshots = _collection.orderBy('roleName').snapshots();
      await for (final snap in snapshots) {
        final items = snap.docs
            .map((d) => RoleEntity.fromMap(d.data(), d.id))
            .toList();
        yield Right(items);
      }
    } on FirebaseException catch (_) {
      yield Left(RoleException());
    } catch (_) {
      yield Left(RoleException());
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

        final newEntity = RoleEntity(
          id: r.id.isEmpty ? docRef.id : r.id,
          roleName: r.roleName.trim(),
          description: r.description.trim(),
          permissions: List<String>.from(r.permissions),
        );

        batch.set(docRef, newEntity.toMap(), SetOptions(merge: false));
        created.add(newEntity);
      }

      await batch.commit();
      return Right(created);
    } on FirebaseException catch (_) {
      return Left(RoleException());
    } catch (_) {
      return Left(RoleException());
    }
  }

  @override
  Future<Either<Failure, RoleEntity>> updateElement({
    required RoleEntity t,
  }) async {
    try {
      if (t.id.isEmpty) return Left(RoleException());

      await _collection.doc(t.id).update({
        'roleName': t.roleName.trim(),
        'description': t.description.trim(),
        'permissions': List<String>.from(t.permissions),
      });

      return Right(t);
    } on FirebaseException catch (_) {
      return Left(RoleException());
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
        if (r.id.isEmpty) return Left(RoleException());
        batch.update(_collection.doc(r.id), {
          'roleName': r.roleName.trim(),
          'description': r.description.trim(),
          'permissions': List<String>.from(r.permissions),
        });
      }
      await batch.commit();
      return Right(ts);
    } on FirebaseException catch (_) {
      return Left(RoleException());
    } catch (_) {
      return Left(RoleException());
    }
  }

  @override
  Future<Either<Failure, RoleEntity>> deleteElement({
    required RoleEntity t,
  }) async {
    try {
      if (t.id.isEmpty) return Left(RoleException());
      await _collection.doc(t.id).delete();
      return Right(t);
    } on FirebaseException catch (_) {
      return Left(RoleException());
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
        if (r.id.isEmpty) return Left(RoleException());
        batch.delete(_collection.doc(r.id));
      }
      await batch.commit();
      return Right(ts);
    } on FirebaseException catch (_) {
      return Left(RoleException());
    } catch (_) {
      return Left(RoleException());
    }
  }
}
