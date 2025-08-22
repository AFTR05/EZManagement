// lib/src/data/repositories/firebase_authentication_repository_impl.dart
import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/auth_exception.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/domain/entities/account_entity.dart';
import 'package:ezmanagement/src/domain/entities/user_entity.dart';
import 'package:ezmanagement/src/domain/enum/auth_provider_enum.dart';
import 'package:ezmanagement/src/domain/repositories/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthenticationRepositoryImpl implements AuthenticationRepository {
  final FirebaseAuth _auth;
  final String accountsCollectionPath;

  FirebaseAuthenticationRepositoryImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
    this.accountsCollectionPath = 'accounts',
  })  : _auth = firebaseAuth;
  bool _isBlank(String? s) => s == null || s.trim().isEmpty;

  Future<String?> _tryGetIdToken(User user) async {
    try {
      final t = await user.getIdToken(true);
      return _isBlank(t) ? null : t;
    } catch (_) {
      return null;
    }
  }

  DateTime? _decodeExpOrNull(String? jwt) {
    if (_isBlank(jwt)) return null;
    try {
      final p = jwt!.split('.')[1];
      final norm = base64Url.normalize(p);
      final payload = json.decode(utf8.decode(base64Url.decode(norm)))
          as Map<String, dynamic>;
      final expMs = (payload['exp'] as int) * 1000;
      return DateTime.fromMillisecondsSinceEpoch(expMs)
          .subtract(const Duration(minutes: 1));
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Either<Failure, AccountEntity>> logIn({
    required String email,
    required String password,
    bool requireEmailVerified = false,
  }) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = cred.user!;
      if (requireEmailVerified && !user.emailVerified) {
        await user.sendEmailVerification();
        await _auth.signOut();
        return Left(_authFailure('Verifica tu correo. Te enviamos un email.'));
      }

      final token = await _tryGetIdToken(user); // String?
      final exp = _decodeExpOrNull(token); // DateTime?

      return Right(AccountEntity(
        uid: user.uid,
        idToken: token,
        expiresAt: exp,
        providers: _mapProviders(user),
        isAuthenticated: true,
      ));
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseAuthException(e));
    } catch (_) {
      return Left(_authFailure('Ocurrió un error al iniciar sesión.'));
    }
  }

  @override
  Future<Either<Failure, AccountEntity>> register({
    required String email,
    required String password,
    UserEntity? profileDraft,
    bool sendEmailVerification = true,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = cred.user!;
      if (sendEmailVerification) {
        await user.sendEmailVerification();
      }
      if (profileDraft != null) {
        //await _db.collection(accountsCollectionPath).doc(user.uid).set({
        //  'uid': user.uid,
        //  'email': profileDraft.email ?? email.trim(),
        //  'firstName': profileDraft.firstName,
        //  'lastName': profileDraft.lastName,
        //  'phone': profileDraft.phone,
        //  'status': profileDraft.status,
        //  'createdAt': DateTime.now().toUtc(),
        //  'updatedAt': DateTime.now().toUtc(),
        //  'lastLoginAt': DateTime.now().toUtc(),
        //}, SetOptions(merge: true));
      }

      final token = await _tryGetIdToken(user);
      final exp = _decodeExpOrNull(token);

      return Right(AccountEntity(
        uid: user.uid,
        idToken: token,
        expiresAt: exp,
        providers: _mapProviders(user),
        isAuthenticated: true,
      ));
    } on FirebaseAuthException catch (e) {
      try {
        await _auth.signOut();
      } catch (_) {}
      return Left(_mapFirebaseAuthException(e));
    } catch (_) {
      try {
        await _auth.signOut();
      } catch (_) {}
      return Left(_authFailure('Ocurrió un error al registrar la cuenta.'));
    }
  }

  @override
  Future<Either<Failure, String>> getFreshIdToken() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return Left(_authFailure('No hay usuario autenticado.'));
      }
      final token = await user.getIdToken(true); // String
      if (_isBlank(token)) return Left(_authFailure('Token vacío.'));
      return Right(token!);
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseAuthException(e));
    } catch (_) {
      return Left(_authFailure('No fue posible obtener el token.'));
    }
  }

  @override
  Future<Either<Failure, AccountEntity?>> currentSession() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return const Right(null);

      final token = await _tryGetIdToken(user);
      final exp = _decodeExpOrNull(token);

      return Right(AccountEntity(
        uid: user.uid,
        idToken: token,
        expiresAt: exp,
        providers: _mapProviders(user),
        isAuthenticated: true,
      ));
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseAuthException(e));
    } catch (_) {
      return Left(_authFailure('No fue posible reconstruir la sesión.'));
    }
  }

  @override
  Future<Either<Failure, bool>> sendPasswordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      return const Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseAuthException(e));
    } catch (_) {
      return Left(
          _authFailure('No fue posible enviar el correo de recuperación.'));
    }
  }

  @override
  Future<Either<Failure, bool>> resendEmailVerification() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return Left(_authFailure('No hay usuario autenticado.'));
      }
      await user.sendEmailVerification();
      return const Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseAuthException(e));
    } catch (_) {
      return Left(
          _authFailure('No fue posible reenviar el correo de verificación.'));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      await _auth.signOut();
      return const Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseAuthException(e));
    } catch (_) {
      return Left(_authFailure('No fue posible cerrar sesión.'));
    }
  }

  @override
  Either<Failure, Map<String, String>> processError(Failure error) {
    return Right({
      'title': 'Error de autenticación',
      'message': error.message,
    });
  }

  Set<AuthProviderEnum> _mapProviders(User user) {
    final ids = user.providerData.map((p) => p.providerId).toSet();
    final result = <AuthProviderEnum>{};
    for (final id in ids) {
      switch (id) {
        case 'password':
          result.add(AuthProviderEnum.password);
          break;
        default:
          break;
      }
    }
    if (result.isEmpty) result.add(AuthProviderEnum.password);
    return result;
  }

  Failure _mapFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return _authFailure('Correo inválido.');
      case 'email-already-in-use':
        return _authFailure('El correo ya está en uso.');
      case 'weak-password':
        return _authFailure('La contraseña es muy débil.');
      case 'user-disabled':
        return _authFailure('Usuario deshabilitado.');
      case 'user-not-found':
      case 'wrong-password':
        return _authFailure('Credenciales inválidas.');
      case 'too-many-requests':
        return _authFailure('Demasiados intentos. Intenta más tarde.');
      case 'network-request-failed':
        return _authFailure('Sin conexión. Verifica tu red.');
      default:
        return _authFailure(e.message ?? 'Error de autenticación.');
    }
  }

  AuthException _authFailure(String msg) => (AuthException()..message = msg);
}
