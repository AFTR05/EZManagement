import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/core/exceptions/user_exception.dart';
import 'package:ezmanagement/src/domain/entities/user_entity.dart';
import 'package:ezmanagement/src/domain/enum/state_enum.dart';
import 'package:ezmanagement/src/domain/repositories/crud/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl({
    FirebaseFirestore? firestore,
    String collectionPath = 'users',
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _collection =
            (firestore ?? FirebaseFirestore.instance).collection(collectionPath);

  final FirebaseFirestore _firestore;
  final CollectionReference<Map<String, dynamic>> _collection;

  // Normaliza 'role' (map, docRef o id) y 'state' (string case-insensitive)
  Map<String, dynamic> _normalize(Map<String, dynamic> data) {
    final normalized = Map<String, dynamic>.from(data);

    // --- state ---
    final rawState = normalized['state'];
    if (rawState is String) {
      final value = rawState.trim();
      final match = StateEnum.values.firstWhere(
        (e) => e.toString().split('.').last.toLowerCase() == value.toLowerCase(),
        orElse: () => StateEnum.active,
      );
      normalized['state'] = match.toString().split('.').last;
    } else if (rawState is StateEnum) {
      normalized['state'] = rawState.toString().split('.').last;
    } else {
      normalized['state'] = StateEnum.active.toString().split('.').last;
    }

    // --- role ---
    final rawRole = normalized['role'];
    // 1) role como Map
    if (rawRole is Map<String, dynamic>) {
      normalized['role'] = Map<String, dynamic>.from(rawRole);
      normalized['roleId'] ??= normalized['role']['id'] ?? '';
    }
    // 2) role como DocumentReference
    else if (rawRole is DocumentReference) {
      normalized['role'] = <String, dynamic>{};
      normalized['roleId'] = rawRole.id;
    }
    // 3) roleId separado como String
    else if (rawRole is String) {
      normalized['role'] = <String, dynamic>{};
      normalized['roleId'] = rawRole;
    } else {
      // nada: garantiza claves presentes
      normalized['role'] = normalized['role'] is Map<String, dynamic>
          ? Map<String, dynamic>.from(normalized['role'])
          : <String, dynamic>{};
      normalized['roleId'] = (normalized['roleId'] ?? '').toString();
    }

    return normalized;
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllElements() async {
    try {
      final snap = await _collection.get();
      final items = snap.docs
          .map((d) => UserEntity.fromMap(_normalize(d.data()), d.id))
          .toList();
      return Right(items);
    } catch (_) {
      return Left(UserException());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getElementById({
    required String id,
  }) async {
    try {
      final doc = await _collection.doc(id).get();
      if (!doc.exists) return Left(UserException());
      return Right(UserEntity.fromMap(_normalize(doc.data()!), doc.id));
    } catch (_) {
      return Left(UserException());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> createElement({
    required UserEntity t,
  }) async {
    try {
      final docRef = t.id.isEmpty ? _collection.doc() : _collection.doc(t.id);

      final newEntity =
          t.id.isEmpty ? UserEntity.fromMap(t.toMap(), docRef.id) : t;

      await docRef.set(newEntity.toMap(), SetOptions(merge: false));
      return Right(newEntity);
    } catch (_) {
      return Left(UserException());
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> createElements({
    required List<UserEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      final created = <UserEntity>[];

      for (final u in ts) {
        final docRef = u.id.isEmpty ? _collection.doc() : _collection.doc(u.id);
        final newEntity =
            u.id.isEmpty ? UserEntity.fromMap(u.toMap(), docRef.id) : u;

        batch.set(docRef, newEntity.toMap(), SetOptions(merge: false));
        created.add(newEntity);
      }

      await batch.commit();
      return Right(created);
    } catch (_) {
      return Left(UserException());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateElement({
    required UserEntity t,
  }) async {
    try {
      await _collection.doc(t.id).update(t.toMap());
      return Right(t);
    } catch (_) {
      return Left(UserException());
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> updateElements({
    required List<UserEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      for (final u in ts) {
        batch.update(_collection.doc(u.id), u.toMap());
      }
      await batch.commit();
      return Right(ts);
    } catch (_) {
      return Left(UserException());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> deleteElement({
    required UserEntity t,
  }) async {
    try {
      await _collection.doc(t.id).delete();
      return Right(t);
    } catch (_) {
      return Left(UserException());
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> deleteElements({
    required List<UserEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      for (final u in ts) {
        batch.delete(_collection.doc(u.id));
      }
      await batch.commit();
      return Right(ts);
    } catch (_) {
      return Left(UserException());
    }
  }
}
