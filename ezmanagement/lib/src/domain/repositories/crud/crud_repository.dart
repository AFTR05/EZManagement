import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/domain/entities/entity_mixin.dart';
abstract class CrudRepository<T extends EntityMixin> {
  ///Function get all T
  Future<Either<Failure, List<T>>> getAllElements();

  ///Get T by id
  Future<Either<Failure, T>> getElementById({
    required String id,
  });

  ///Create T
  Future<Either<Failure, dynamic>> createElement({
    required T t,
  });

  ///Create multiple T
  Future<Either<Failure, dynamic>> createElements({
    required List<T> ts,
  });

  ///Update a T
  Future<Either<Failure, dynamic>> updateElement({
    required T t,
  });

  ///Update multiple T
  Future<Either<Failure, dynamic>> updateElements({
    required List<T> ts,
  });

  ///Delete a T
  Future<Either<Failure, dynamic>> deleteElement({
    required T t,
  });

  ///Delete multiple T
  Future<Either<Failure, dynamic>> deleteElements({
    required List<T> ts,
  });
}
