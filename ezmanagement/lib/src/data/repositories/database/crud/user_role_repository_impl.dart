import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/core/exceptions/user_role_exception.dart';
import 'package:ezmanagement/src/domain/entities/user_role_entity.dart';
import 'package:ezmanagement/src/domain/repositories/crud/user_role_repository.dart';

class UserRoleRepositoryImpl extends UserRoleRepository {
  UserRoleRepositoryImpl({
    FirebaseFirestore? firestore,
    String collectionPath = 'user_roles',
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _collection =
            (firestore ?? FirebaseFirestore.instance).collection(collectionPath);

  final FirebaseFirestore _firestore;
  final CollectionReference<Map<String, dynamic>> _collection;

  // ID compuesto para permitir historial de periodos del mismo rol/permiso
  // Formato: userId_roleId_permissionId_beginDateEpochMs
  String _docIdFor(UserRoleEntity e) =>
      '${e.userId}_${e.roleId}_${e.permissionId}_${e.beginDate.toUtc().millisecondsSinceEpoch}';

  Map<String, dynamic> _normalize(Map<String, dynamic> data) {
    final normalized = Map<String, dynamic>.from(data);

    final bd = normalized['beginDate'];
    if (bd is Timestamp) {
      normalized['beginDate'] = bd.toDate().toIso8601String();
    } else if (bd is DateTime) {
      normalized['beginDate'] = bd.toIso8601String();
    } else if (bd is String) {
      // ok
    } else {
      normalized['beginDate'] = DateTime.now().toIso8601String();
    }

    final ed = normalized['endDate'];
    if (ed is Timestamp) {
      normalized['endDate'] = ed.toDate().toIso8601String();
    } else if (ed is DateTime) {
      normalized['endDate'] = ed.toIso8601String();
    } else if (ed == null || ed is String) {
      // ok (null o String)
    } else {
      normalized['endDate'] = null;
    }

    return normalized;
  }

  @override
  Future<Either<Failure, List<UserRoleEntity>>> getAllElements() async {
    try {
      final snap = await _collection.get();
      final items = snap.docs
          .map((d) => UserRoleEntity.fromMap(_normalize(d.data()), d.id))
          .toList();
      return Right(items);
    } catch (_) {
      return Left(UserRoleException());
    }
  }

  @override
  Future<Either<Failure, UserRoleEntity>> getElementById({
    required String id,
  }) async {
    try {
      final doc = await _collection.doc(id).get();
      if (!doc.exists) return Left(UserRoleException());
      return Right(UserRoleEntity.fromMap(_normalize(doc.data()!), doc.id));
    } catch (_) {
      return Left(UserRoleException());
    }
  }

  @override
  Future<Either<Failure, UserRoleEntity>> createElement({
    required UserRoleEntity t,
  }) async {
    try {
      final docRef = _collection.doc(_docIdFor(t));
      await docRef.set(t.toMap(), SetOptions(merge: false));
      return Right(t);
    } catch (_) {
      return Left(UserRoleException());
    }
  }

  @override
  Future<Either<Failure, List<UserRoleEntity>>> createElements({
    required List<UserRoleEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      for (final e in ts) {
        batch.set(_collection.doc(_docIdFor(e)), e.toMap(), SetOptions(merge: false));
      }
      await batch.commit();
      return Right(ts);
    } catch (_) {
      return Left(UserRoleException());
    }
  }

  @override
  Future<Either<Failure, UserRoleEntity>> updateElement({
    required UserRoleEntity t,
  }) async {
    try {
      // Como el ID depende de beginDate, si cambias beginDate tendrías que re-crear el doc.
      await _collection.doc(_docIdFor(t)).update(t.toMap());
      return Right(t);
    } catch (_) {
      return Left(UserRoleException());
    }
  }

  @override
  Future<Either<Failure, List<UserRoleEntity>>> updateElements({
    required List<UserRoleEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      for (final e in ts) {
        batch.update(_collection.doc(_docIdFor(e)), e.toMap());
      }
      await batch.commit();
      return Right(ts);
    } catch (_) {
      return Left(UserRoleException());
    }
  }

  @override
  Future<Either<Failure, UserRoleEntity>> deleteElement({
    required UserRoleEntity t,
  }) async {
    try {
      await _collection.doc(_docIdFor(t)).delete();
      return Right(t);
    } catch (_) {
      return Left(UserRoleException());
    }
  }

  @override
  Future<Either<Failure, List<UserRoleEntity>>> deleteElements({
    required List<UserRoleEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      for (final e in ts) {
        batch.delete(_collection.doc(_docIdFor(e)));
      }
      await batch.commit();
      return Right(ts);
    } catch (_) {
      return Left(UserRoleException());
    }
  }
}
