import 'package:ezmanagement/src/domain/usecases/authentication_usecase.dart';
import 'package:ezmanagement/src/inject/riverpod_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'riverpod_usecase.g.dart';

@riverpod
AuthenticationUsecase authenticationUsecase(Ref ref){
  return AuthenticationUsecase(authRepository: ref.watch(authenticationRepositoryProvider));
}