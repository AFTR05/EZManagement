import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/domain/entities/account_entity.dart';
import 'package:ezmanagement/src/domain/usecases/authentication_usecase.dart';
import 'package:ezmanagement/src/inject/app_states/auth_loading_provider.dart';
import 'package:ezmanagement/src/routes_app.dart';
import 'package:ezmanagement/src/utils/scaffold_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationController extends ChangeNotifier {

  final AuthenticationUsecase authenticationUsecase;
  final Ref ref;
  AccountEntity? _session;
  AccountEntity? get session => _session;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  AuthenticationController({required this.ref,required this.authenticationUsecase});
  
  Future<Either<Failure, bool>> signIn({
    required String email,
    required String password,
    bool requireEmailVerified = false,
  }) async {
    ref.read(authLoadingProvider.notifier).start();
    final res = await authenticationUsecase.signIn(LogInParams(
      email: email,
      password: password,
      requireEmailVerified: requireEmailVerified,
    ));

    return await res.fold(
      (failure) async {
        _errorMessage = failure.message;
        // ⬇️ apaga loader en error
        ref.read(authLoadingProvider.notifier).stop();
        notifyListeners();
        return Left(failure);
      },
      (auth) async {
        _session = auth;
        // await accountUC.touchLoginAt();
        // final p = await accountUC.getAccount();
        // p.fold(
        //   (f) => _errorMessage = f.message,
        //   (acc) => _profile = acc,
        // );
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
  }) async {
    final result = await signIn(email: email, password: password);
    if (result.isRight && result.right) {
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

}