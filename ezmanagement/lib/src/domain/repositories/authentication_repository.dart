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
    bool rememberMe = true,
  });

  Future<Either<Failure, AccountEntity>> register({
    required String email,
    required String password,
    bool sendEmailVerification = true,
  });

  Future<Either<Failure, String>> getFreshIdToken();

  Future<Either<Failure, AccountEntity?>> currentSession();
  Future<AccountEntity?> restoredSessionOnce({Duration timeout});

  Future<Either<Failure, bool>> sendPasswordReset(String email);
  Future<Either<Failure, bool>> resendEmailVerification();
  Future<Either<Failure, bool>> logout();

  Either<Failure, Map<String, String>> processError(Failure error);
  Future<void> setRememberMe(bool value);
  Future<bool> getRememberMe();
  Future<void> clearRememberMe();
  Future<void> setLastLoginUid(String uid);
  Future<String?> getLastLoginUid();
  Future<void> clearLastLoginUid();

  Future<void> setLastLoginEmail(String email);
  Future<String?> getLastLoginEmail();
  Future<void> clearLastLoginEmail();
}
