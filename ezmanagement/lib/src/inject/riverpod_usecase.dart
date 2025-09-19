import 'package:ezmanagement/src/domain/usecases/authentication_usecase.dart';
import 'package:ezmanagement/src/domain/usecases/role_usecase.dart';
import 'package:ezmanagement/src/domain/usecases/user_usecase.dart';
import 'package:ezmanagement/src/inject/riverpod_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'riverpod_usecase.g.dart';

@riverpod
AuthenticationUsecase authenticationUsecase(Ref ref){
  return AuthenticationUsecase(authRepository: ref.watch(authenticationRepositoryProvider));
}

@riverpod
UserUsecase userUsecase(Ref ref){
  return UserUsecase(userRepository: ref.watch(userRepositoryProvider), userCRUDRepository: ref.watch(userCRUDRepositoryProvider));
}

@riverpod
RoleUsecase roleUsecase(Ref ref){
  return RoleUsecase(roleRepository: ref.watch(roleRepositoryProvider));
}