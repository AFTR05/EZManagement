import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/domain/entities/user_entity.dart';
import 'package:ezmanagement/src/domain/repositories/crud/crud_repository.dart';

abstract class UserCRUDRepository extends CrudRepository<UserEntity> {
  @override
  Future<Either<Failure, List<UserEntity>>> getAllElements() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> getElementById({required String id}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> createElement({required UserEntity t}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<UserEntity>>> createElements({
    required List<UserEntity> ts,
  }) {
    throw UnimplementedError();
  }

  Stream<Either<Failure, List<UserEntity>>> watchAllElements(){
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> updateElement({required UserEntity t}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<UserEntity>>> updateElements({
    required List<UserEntity> ts,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> deleteElement({required UserEntity t}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<UserEntity>>> deleteElements({
    required List<UserEntity> ts,
  }) {
    throw UnimplementedError();
  }
}
