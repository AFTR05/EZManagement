import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getAccount();

  /// Crea/actualiza el perfil (sin token)
  Future<Either<Failure, bool>> setAccount({required UserEntity entity});

  /// Actualiza lastLoginAt/updatedAt
  Future<Either<Failure, bool>> touchLoginAt();

  /// Cierra sesión (delegado a FirebaseAuth)
  Future<Either<Failure, bool>> logoutAccount();
}