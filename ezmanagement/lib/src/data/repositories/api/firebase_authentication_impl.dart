import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/auth_exception.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/domain/entities/client_entity.dart';
import 'package:ezmanagement/src/domain/repositories/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticationImpl extends AuthenticationRepository {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthenticationImpl({required this.firebaseAuth});

  @override
  Future<Either<Failure, ClientEntity>> auth(AuthenticationParams params) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: params.username,
        password: params.password,
      );

      ClientEntity account = ClientEntity(
        name: "empanada",
        nit: "sos",
        direction: "",
        email: userCredential.user?.email ?? '',
        id: userCredential.user?.uid ?? '',
      );
      return Right(account);
    } catch (e) {
      return Left(AuthException());
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      await firebaseAuth.signOut();
      return Right(true);
    } catch (e) {
      return Left(AuthException());
    }
  }

  @override
  Either<Failure, Map<String, dynamic>> processErrorResponse({required Failure errorResponse}) {
    return Left(AuthException());
  }
}