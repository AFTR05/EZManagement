import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/domain/entities/user_entity.dart';
import 'package:ezmanagement/src/domain/repositories/user_repository.dart';

class UserUsecase {
  final UserRepository userRepository;
  UserUsecase({required this.userRepository});

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
}
