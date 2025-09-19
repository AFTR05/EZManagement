import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/domain/entities/role_entity.dart';
import 'package:ezmanagement/src/domain/entities/user_entity.dart';
import 'package:ezmanagement/src/domain/enum/state_enum.dart';
import 'package:ezmanagement/src/domain/repositories/crud/user_repository.dart';
import 'package:ezmanagement/src/domain/repositories/user_repository.dart';

class UserUsecase {
  final UserRepository userRepository;
  final UserCRUDRepository userCRUDRepository;
  UserUsecase({required this.userRepository, required this.userCRUDRepository});

  Future<Either<Failure, UserEntity>> getAccount() {
    return userRepository.getAccount();
  }

  Future<Either<Failure, bool>> setAccount(UserEntity entity) {
    return userRepository.setAccount(entity: entity);
  }

  Future<Either<Failure, bool>> touchLoginAt() {
    return userRepository.touchLoginAt();
  }

  Future<Either<Failure, bool>> logoutAccount() {
    return userRepository.logoutAccount();
  }

  Stream<Either<Failure, List<UserEntity>>> watchAllElements() {
    return userCRUDRepository.watchAllElements();
  }

  Future<Either<Failure, UserEntity>> createUser({
    required String uuid,
    required String name,
    required String email,
    required RoleEntity role,
    required String password,
  }) {
    final user = UserEntity(
      uid: uuid,
      email: email,
      name: name,
      roleId: role.id,
      roleName: role.roleName,
      createdAt: DateTime.now(),
      status: StateEnum.active,
      updatedAt: DateTime.now()
    );
    return userCRUDRepository.createElement(t: user);
  }
}
