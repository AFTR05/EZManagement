import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/domain/entities/product_entity.dart';
import 'package:ezmanagement/src/domain/repositories/crud/crud_repository.dart';

abstract class ProductRepository extends CrudRepository<ProductEntity> {
  @override
  Future<Either<Failure, List<ProductEntity>>> getAllElements() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ProductEntity>> getElementById({required String id}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> createElement({required ProductEntity t}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> createElements({
    required List<ProductEntity> ts,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> updateElement({required ProductEntity t}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> updateElements({
    required List<ProductEntity> ts,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> deleteElement({required ProductEntity t}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> deleteElements({
    required List<ProductEntity> ts,
  }) {
    throw UnimplementedError();
  }
}
