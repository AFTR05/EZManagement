import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/domain/entities/user_role_entity.dart';
import 'package:ezmanagement/src/domain/repositories/crud/crud_repository.dart';

abstract class UserRoleRepository extends CrudRepository<UserRoleEntity> {
  @override
  Future<Either<Failure, List<UserRoleEntity>>> getAllElements() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserRoleEntity>> getElementById({required String id}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> createElement({required UserRoleEntity t}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> createElements({
    required List<UserRoleEntity> ts,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> updateElement({required UserRoleEntity t}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> updateElements({
    required List<UserRoleEntity> ts,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> deleteElement({required UserRoleEntity t}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> deleteElements({
    required List<UserRoleEntity> ts,
  }) {
    throw UnimplementedError();
  }
}
