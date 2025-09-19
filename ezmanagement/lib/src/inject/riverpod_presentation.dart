import 'package:ezmanagement/src/inject/riverpod_usecase.dart';
import 'package:ezmanagement/src/presentation/controllers/auth/authentication_controller.dart';
import 'package:ezmanagement/src/presentation/controllers/role_controller.dart';
import 'package:ezmanagement/src/presentation/controllers/user_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'riverpod_presentation.g.dart';

@riverpod
AuthenticationController authenticationController(Ref ref) {
  return AuthenticationController(
    ref: ref,
    userUsecase: ref.watch(userUsecaseProvider),
    authenticationUsecase: ref.watch(authenticationUsecaseProvider),
  );
}

@riverpod
RoleController roleController(Ref ref) {
  return RoleController(roleUsecase: ref.watch(roleUsecaseProvider));
}

@riverpod
UserController userController(Ref ref) {
  return UserController(
    userUsecase: ref.watch(userUsecaseProvider),
    authenticationUsecase: ref.watch(authenticationUsecaseProvider),
  );
}
