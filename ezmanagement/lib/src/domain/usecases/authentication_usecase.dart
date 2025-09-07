import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/domain/entities/account_entity.dart';
import 'package:ezmanagement/src/domain/entities/user_entity.dart';
import 'package:ezmanagement/src/domain/repositories/authentication_repository.dart';

class LogInParams {
  final String email;
  final String password;
  final bool requireEmailVerified;
  final bool rememberMe;
  const LogInParams({
    required this.email,
    required this.password,
    this.requireEmailVerified = true,
    this.rememberMe = false,
  });
}

class RegisterParams {
  final String email;
  final String password;
  final UserEntity? profileDraft;
  final bool sendEmailVerification;
  const RegisterParams({
    required this.email,
    required this.password,
    this.profileDraft,
    this.sendEmailVerification = true,
  });
}

class AuthenticationUsecase {
  final AuthenticationRepository authRepository;
  AuthenticationUsecase({required this.authRepository});

  Future<Either<Failure, AccountEntity>> signIn(LogInParams params) {
    return authRepository.logIn(
      email: params.email,
      password: params.password,
      requireEmailVerified: params.requireEmailVerified,
      rememberMe: params.rememberMe,
    );
  }

  Future<AccountEntity?> restoredSessionOnce(
      {Duration timeout = const Duration(seconds: 2)}) {
    return authRepository.restoredSessionOnce(timeout: timeout);
  }

  Future<Either<Failure, AccountEntity>> signUp(RegisterParams params) {
    return authRepository.register(
      email: params.email,
      password: params.password,
      profileDraft: params.profileDraft,
      sendEmailVerification: params.sendEmailVerification,
    );
  }

  Future<Either<Failure, String>> getFreshIdToken() {
    return authRepository.getFreshIdToken();
  }

  Future<Either<Failure, AccountEntity?>> currentSession() {
    return authRepository.currentSession();
  }

  Future<Either<Failure, bool>> sendPasswordReset(String email) {
    return authRepository.sendPasswordReset(email);
  }

  Future<Either<Failure, bool>> resendEmailVerification() {
    return authRepository.resendEmailVerification();
  }

  Future<Either<Failure, bool>> logout() {
    return authRepository.logout();
  }

  Either<Failure, Map<String, String>> processError(Failure error) {
    return authRepository.processError(error);
  }

  Future<void> setRememberMe(bool v) => authRepository.setRememberMe(v);
  Future<bool> getRememberMe() => authRepository.getRememberMe();
  Future<void> clearRememberMe() => authRepository.clearRememberMe();
  Future<void> setLastLoginUid(String uid) =>
      authRepository.setLastLoginUid(uid);
  Future<String?> getLastLoginUid() => authRepository.getLastLoginUid();
  Future<void> clearLastLoginUid() => authRepository.clearLastLoginUid();

  Future<void> setLastLoginEmail(String email) =>
      authRepository.setLastLoginEmail(email);
  Future<String?> getLastLoginEmail() => authRepository.getLastLoginEmail();
  Future<void> clearLastLoginEmail() => authRepository.clearLastLoginEmail();
}
