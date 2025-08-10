import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/domain/entities/client_entity.dart';
import 'package:ezmanagement/src/domain/repositories/authentication_repository.dart';

class AuthenticationUsecase {
  final AuthenticationRepository authRepository;

  AuthenticationUsecase({required this.authRepository});

  Future<Either<Failure, ClientEntity>> signIn(AuthenticationParams params) async {
    return await authRepository.auth(params);
  }

  Future<Either<Failure, bool>> logout() async {
    return await authRepository.logout();
  }
  
  
}