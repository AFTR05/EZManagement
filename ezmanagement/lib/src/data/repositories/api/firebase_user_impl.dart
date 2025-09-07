// lib/src/data/repositories/firestore_account_repository_impl.dart
import 'package:either_dart/either.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezmanagement/src/core/exceptions/auth_exception.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/domain/entities/user_entity.dart';
import 'package:ezmanagement/src/domain/enum/state_enum.dart';
import 'package:ezmanagement/src/domain/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreUserRepositoryImpl implements UserRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;
  final String usersCollectionPath;

  FirestoreUserRepositoryImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
    this.usersCollectionPath = 'users',
  }) : _auth = firebaseAuth,
       _db = firestore;

  @override
  Future<Either<Failure, UserEntity>> getAccount() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return Left(_err('No hay usuario autenticado.'));

      final ref = _db.collection(usersCollectionPath).doc(user.uid);
      final snap = await ref.get();

      if (!snap.exists) {
        final entity = UserEntity(uid: user.uid, email: user.email);
        await setAccount(entity: entity);
        return Right(entity);
      }

      return Right(_fromDoc(user.uid, snap.data()!));
    } catch (_) {
      return Left(_err('No fue posible obtener el perfil.'));
    }
  }

  @override
  Future<Either<Failure, bool>> setAccount({required UserEntity entity}) async {
    try {
      final ref = _db.collection(usersCollectionPath).doc(entity.uid);
      await ref.set({
        'uid': entity.uid,
        'email': entity.email,
        'roleId': entity.roleId,
        'roleName': entity.roleName,
        'name': entity.name,
        'status': entity.status,
        'createdAt': entity.createdAt ?? FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'lastLoginAt': entity.lastLoginAt ?? FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      return const Right(true);
    } catch (_) {
      return Left(_err('No fue posible guardar el perfil.'));
    }
  }

  @override
  Future<Either<Failure, bool>> touchLoginAt() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return Left(_err('No hay usuario autenticado.'));

      //await _db.collection(accountsCollectionPath).doc(user.uid).set({
      //  'lastLoginAt': FieldValue.serverTimestamp(),
      //  'updatedAt': FieldValue.serverTimestamp(),
      //}, SetOptions(merge: true));

      return const Right(true);
    } catch (_) {
      return Left(_err('No fue posible actualizar las fechas.'));
    }
  }

  @override
  Future<Either<Failure, bool>> logoutAccount() async {
    try {
      await _auth.signOut();
      return const Right(true);
    } catch (_) {
      return Left(_err('No fue posible cerrar sesión.'));
    }
  }

  // -------- Helpers --------

  UserEntity _fromDoc(String uid, Map<String, dynamic> data) {
    DateTime? toDate(dynamic v) {
      if (v == null) return null;
      if (v is Timestamp) return v.toDate();
      if (v is DateTime) return v;
      return null;
    }

    return UserEntity(
      uid: uid,
      email: data['email'] as String?,
      name: data['name'] as String?,
      roleId: data["roleId"] as String?,
      roleName: data["roleName"] as String?,
      status: _parseStateEnum(data['status'] as String?),
      createdAt: toDate(data['createdAt']),
      updatedAt: toDate(data['updatedAt']),
      lastLoginAt: toDate(data['lastLoginAt']),
    );
  }

  StateEnum _parseStateEnum(String? statusString) {
    if (statusString == null) return StateEnum.active;

    switch (statusString.toLowerCase()) {
      case 'active':
        return StateEnum.active;
      case 'inactive':
        return StateEnum.inactive;
      default:
        return StateEnum.active; // valor por defecto
    }
  }

  AuthException _err(String msg) => (AuthException()..message = msg);
}
