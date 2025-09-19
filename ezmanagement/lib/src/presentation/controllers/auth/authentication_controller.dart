import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/domain/entities/account_entity.dart';
import 'package:ezmanagement/src/domain/entities/user_entity.dart';
import 'package:ezmanagement/src/domain/usecases/authentication_usecase.dart';
import 'package:ezmanagement/src/domain/usecases/user_usecase.dart';
import 'package:ezmanagement/src/inject/app_states/auth_loading_provider.dart';
import 'package:ezmanagement/src/inject/states_providers/login_provider.dart';
import 'package:ezmanagement/src/routes_app.dart';
import 'package:ezmanagement/src/utils/scaffold_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationController extends ChangeNotifier {
  final AuthenticationUsecase authenticationUsecase;
  final UserUsecase userUsecase;
  final Ref ref;

  AccountEntity? _session;
  AccountEntity? get session => _session;
  UserEntity? _profile;
  UserEntity? get profile => _profile;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  AuthenticationController({
    required this.ref,
    required this.authenticationUsecase,
    required this.userUsecase,
  });

  Future<Either<Failure, bool>> signIn({
    required String email,
    required String password,
    bool requireEmailVerified = false,
    bool rememberMe = true,
  }) async {
    ref.read(authLoadingProvider.notifier).start();
    final res = await authenticationUsecase.signIn(
      LogInParams(
        email: email,
        password: password,
        requireEmailVerified: requireEmailVerified,
        rememberMe: rememberMe,
      ),
    );

    return await res.fold(
      (failure) async {
        _errorMessage = failure.message;
        ref.read(authLoadingProvider.notifier).stop();
        notifyListeners();
        return Left(failure);
      },
      (auth) async {
        _session = auth;
        await userUsecase.touchLoginAt();
        final p = await userUsecase.getAccount();
        p.fold((f) => _errorMessage = f.message, (acc) => _profile = acc);
        ref.read(authLoadingProvider.notifier).stop();
        notifyListeners();
        return const Right(true);
      },
    );
  }

  Future<Either<Failure, bool>> loginAction({
    required String email,
    required String password,
    required BuildContext context,
    bool rememberMe = true,
  }) async {
    final result = await signIn(
      email: email,
      password: password,
      requireEmailVerified: false,
      rememberMe: rememberMe,
    );
    if (result.isRight && result.right) {
      final auth = getAccount();
      if (auth != null) {
        await authenticationUsecase.setRememberMe(rememberMe);
        await authenticationUsecase.setLastLoginUid(auth.uid);
      }
      await authenticationUsecase.setLastLoginEmail(email);
      if (context.mounted) {
        Navigator.of(context).popAndPushNamed(RoutesApp.home);
      }
      return const Right(true);
    } else {
      final failure = result.left;
      if (context.mounted) {
        ScaffoldUtils.showSnackBar(
          context: context,
          msg: failure.message,
          color: Colors.red,
        );
      }
      return Left(failure);
    }
  }

  Future<bool> isLoggedUser() async {
    final remember = await authenticationUsecase.getRememberMe();
    if (!remember) return false;
    final allowedUid = await authenticationUsecase.getLastLoginUid();
    if (allowedUid == null || allowedUid.trim().isEmpty) return false;
    final auth = await authenticationUsecase.restoredSessionOnce(
      timeout: const Duration(seconds: 2),
    );
    if (auth == null) return false;
    if (auth.uid != allowedUid) {
      await authenticationUsecase.logout();
      return false;
    }
    setAccountToState(account: auth);
    final p = userUsecase.getAccount();
    p.fold((f) => _errorMessage = f.message, (acc) => _profile = acc);
    notifyListeners();
    return true;
  }

  void setAccountToState({required AccountEntity? account}) {
    ref.read(loginProviderProvider.notifier).setState(account);
  }

  AccountEntity? getAccount() {
    return ref.read(loginProviderProvider);
  }

  Future<void> loadCurrentSession() async {
    final res = await authenticationUsecase.currentSession();
    res.fold(
      (failure) => _errorMessage = failure.message,
      (auth) => setAccountToState(account: auth),
    );

    if (getAccount() != null) {
      final p = await userUsecase.getAccount();
      p.fold((f) => _errorMessage = f.message, (acc) => _profile = acc);
    }
    notifyListeners();
  }
}
