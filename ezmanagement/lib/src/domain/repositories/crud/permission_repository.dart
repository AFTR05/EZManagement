import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/domain/entities/permission_entity.dart';
import 'package:ezmanagement/src/domain/repositories/crud/crud_repository.dart';

abstract class PermissionRepository extends CrudRepository<PermissionEntity> {
  @override
  Future<Either<Failure, List<PermissionEntity>>> getAllElements() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PermissionEntity>> getElementById({required String id}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> createElement({required PermissionEntity t}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> createElements({
    required List<PermissionEntity> ts,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> updateElement({required PermissionEntity t}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> updateElements({
    required List<PermissionEntity> ts,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> deleteElement({required PermissionEntity t}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> deleteElements({
    required List<PermissionEntity> ts,
  }) {
    throw UnimplementedError();
  }
}
