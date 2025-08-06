import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/domain/entities/material_output_entity.dart';
import 'package:ezmanagement/src/domain/repositories/crud/crud_repository.dart';

abstract class MaterialOutputRepository extends CrudRepository<MaterialOutputEntity> {
  @override
  Future<Either<Failure, List<MaterialOutputEntity>>> getAllElements() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, MaterialOutputEntity>> getElementById({
    required String id,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> createElement({
    required MaterialOutputEntity t,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> createElements({
    required List<MaterialOutputEntity> ts,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> updateElement({
    required MaterialOutputEntity t,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> updateElements({
    required List<MaterialOutputEntity> ts,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> deleteElement({
    required MaterialOutputEntity t,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> deleteElements({
    required List<MaterialOutputEntity> ts,
  }) {
    throw UnimplementedError();
  }
}
