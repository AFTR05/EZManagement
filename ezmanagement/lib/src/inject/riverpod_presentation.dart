
import 'package:ezmanagement/src/inject/riverpod_usecase.dart';
import 'package:ezmanagement/src/presentation/controllers/auth/authentication_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'riverpod_presentation.g.dart';

@riverpod
AuthenticationController authenticationController(Ref ref){
  return AuthenticationController(
    authenticationUsecase: ref.watch(authenticationUsecaseProvider),
  );
}