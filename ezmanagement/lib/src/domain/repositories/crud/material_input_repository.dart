import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/domain/entities/material_input_entity.dart';
import 'package:ezmanagement/src/domain/repositories/crud/crud_repository.dart';

abstract class MaterialInputRepository  extends CrudRepository<MaterialInputEntity> {
  @override
  Future<Either<Failure, List<MaterialInputEntity>>> getAllElements(){
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, MaterialInputEntity>> getElementById({
    required String id,
  }){
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> createElement({
    required MaterialInputEntity t,
  }){
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> createElements({
    required List<MaterialInputEntity> ts,
  }){
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> updateElement({
    required MaterialInputEntity t,
  }){
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> updateElements({
    required List<MaterialInputEntity> ts,
  }){
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> deleteElement({
    required MaterialInputEntity t,
  }){
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> deleteElements({
    required List<MaterialInputEntity> ts,
  }){
    throw UnimplementedError();
  }
}