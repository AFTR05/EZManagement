import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/domain/entities/role_entity.dart';
import 'package:ezmanagement/src/domain/repositories/crud/crud_repository.dart';

abstract class RoleRepository extends CrudRepository<RoleEntity> {
  @override
  Future<Either<Failure, List<RoleEntity>>> getAllElements() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, RoleEntity>> getElementById({required String id}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, RoleEntity>> createElement({required RoleEntity t}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<RoleEntity>>> createElements({
    required List<RoleEntity> ts,
  }) {
    throw UnimplementedError();
  }

  Stream<Either<Failure, List<RoleEntity>>> watchAllElements(){
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, RoleEntity>> updateElement({required RoleEntity t}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<RoleEntity>>> updateElements({
    required List<RoleEntity> ts,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, RoleEntity>> deleteElement({required RoleEntity t}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<RoleEntity>>> deleteElements({
    required List<RoleEntity> ts,
  }) {
    throw UnimplementedError();
  }
}
