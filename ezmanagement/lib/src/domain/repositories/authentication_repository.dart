// lib/src/domain/repositories/authentication_repository.dart
import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/domain/entities/account_entity.dart';
import 'package:ezmanagement/src/domain/entities/user_entity.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, AccountEntity>> logIn({
    required String email,
    required String password,
    bool requireEmailVerified = true,
  });

  Future<Either<Failure, AccountEntity>> register({
    required String email,
    required String password,
    UserEntity? profileDraft,
    bool sendEmailVerification = true,
  });

  Future<Either<Failure, String>> getFreshIdToken();

  Future<Either<Failure, AccountEntity?>> currentSession();

  Future<Either<Failure, bool>> sendPasswordReset(String email);
  Future<Either<Failure, bool>> resendEmailVerification();
  Future<Either<Failure, bool>> logout();

  Either<Failure, Map<String, String>> processError(Failure error);
}
