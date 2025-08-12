import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/domain/entities/client_entity.dart';

abstract class AuthenticationRepository {
  ///Function to auth with username and password in app
  Future<Either<Failure, ClientEntity>> auth(AuthenticationParams params);

  ///Function logout device
  Future<Either<Failure, bool>> logout();

  ///Function process login error
  Either<Failure, Map<String, dynamic>> processErrorResponse({
    required Failure errorResponse,
  });
}

class AuthenticationParams {
  final String username;
  final String password;

  AuthenticationParams({required this.username, required this.password});
}
