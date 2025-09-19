import 'package:ezmanagement/src/domain/entities/role_entity.dart';
import 'package:ezmanagement/src/domain/entities/user_entity.dart';
import 'package:ezmanagement/src/domain/usecases/authentication_usecase.dart';
import 'package:ezmanagement/src/domain/usecases/user_usecase.dart';

class UserController {
  final UserUsecase _userUsecase;
  final AuthenticationUsecase _authenticationUsecase;

  UserController({
    required UserUsecase userUsecase,
    required AuthenticationUsecase authenticationUsecase,
  }) : _userUsecase = userUsecase,
       _authenticationUsecase = authenticationUsecase;

  Future<void> createUser({
    required String name,
    required String email,
    required RoleEntity role,
    required String password,
    bool sendEmailVerification = true,
  }) async {
    await _userUsecase.createUser(
      name: name,
      email: email,
      role: role,
      password: password,
    );
    final registerParams = RegisterParams(
      email: email,
      password: password,
      sendEmailVerification: sendEmailVerification,
    );
    await _authenticationUsecase.signUp(registerParams);
  }

  Stream<List<UserEntity>> watchAllElements() {
    return _userUsecase.watchAllElements().map(
      (either) => either.fold((_) => const <UserEntity>[], (list) => list),
    );
  }
}
