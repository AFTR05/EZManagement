import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/domain/entities/client_entity.dart';
import 'package:ezmanagement/src/domain/repositories/crud/crud_repository.dart';

abstract class ClientRepository  extends CrudRepository<ClientEntity> {
  @override
  Future<Either<Failure, List<ClientEntity>>> getAllElements(){
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ClientEntity>> getElementById({
    required String id,
  }){
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> createElement({
    required ClientEntity t,
  }){
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> createElements({
    required List<ClientEntity> ts,
  }){
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> updateElement({
    required ClientEntity t,
  }){
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> updateElements({
    required List<ClientEntity> ts,
  }){
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> deleteElement({
    required ClientEntity t,
  }){
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> deleteElements({
    required List<ClientEntity> ts,
  }){
    throw UnimplementedError();
  }
}