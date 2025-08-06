import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/domain/entities/delivery_entity.dart';
import 'package:ezmanagement/src/domain/repositories/crud/crud_repository.dart';

abstract class DeliveryRepository  extends CrudRepository<DeliveryEntity> {
  @override
  Future<Either<Failure, List<DeliveryEntity>>> getAllElements(){
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, DeliveryEntity>> getElementById({
    required String id,
  }){
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> createElement({
    required DeliveryEntity t,
  }){
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> createElements({
    required List<DeliveryEntity> ts,
  }){
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> updateElement({
    required DeliveryEntity t,
  }){
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> updateElements({
    required List<DeliveryEntity> ts,
  }){
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> deleteElement({
    required DeliveryEntity t,
  }){
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> deleteElements({
    required List<DeliveryEntity> ts,
  }){
    throw UnimplementedError();
  }
}