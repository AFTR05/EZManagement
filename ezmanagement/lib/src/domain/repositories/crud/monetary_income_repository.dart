import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/domain/entities/monetary_income_entity.dart';
import 'package:ezmanagement/src/domain/repositories/crud/crud_repository.dart';

abstract class MonetaryIncomeRepository extends CrudRepository<MonetaryIncomeEntity> {
  @override
  Future<Either<Failure, List<MonetaryIncomeEntity>>> getAllElements() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, MonetaryIncomeEntity>> getElementById({required String id}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> createElement({required MonetaryIncomeEntity t}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> createElements({
    required List<MonetaryIncomeEntity> ts,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> updateElement({required MonetaryIncomeEntity t}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> updateElements({
    required List<MonetaryIncomeEntity> ts,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> deleteElement({required MonetaryIncomeEntity t}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> deleteElements({
    required List<MonetaryIncomeEntity> ts,
  }) {
    throw UnimplementedError();
  }
}
