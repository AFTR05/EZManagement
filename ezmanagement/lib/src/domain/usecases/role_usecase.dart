import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/domain/entities/role_entity.dart';
import 'package:ezmanagement/src/domain/enum/permission_enum.dart';
import 'package:ezmanagement/src/domain/repositories/crud/role_repository.dart';

class RoleUsecase {
  final RoleRepository roleRepository;
  RoleUsecase({required this.roleRepository});

  Future<Either<Failure, List<RoleEntity>>> getRoles() async {
    return await roleRepository.getAllElements();
  }

  Future<Either<Failure, RoleEntity>> createRole({
    required String roleName,
    required String description,
    required List<PermissionEnum> permissions,
  }) async {
    final stringPermissions = PermissionEnum.toStrings(permissions);
    final role = RoleEntity(
      id: '',
      roleName: roleName,
      description: description,
      permissions: stringPermissions,
    );
    return await roleRepository.createElement(t: role);
  }

  Future<Either<Failure, RoleEntity>> updateRole({
    required String id,
    required String roleName,
    required String description,
    required List<PermissionEnum> permissions,
  }) async {
    final stringPermissions = PermissionEnum.toStrings(permissions);
    final role = RoleEntity(
      id: id,
      roleName: roleName,
      description: description,
      permissions: stringPermissions,
    );
    return await roleRepository.updateElement(t: role);
  }


  Stream<Either<Failure, List<RoleEntity>>> watchAllElements() {
    return roleRepository.watchAllElements();
  }


  Future<Either<Failure, RoleEntity>> deleteRole({
    required String id,
  }) async {
    final role = await roleRepository.getElementById(id: id);
    if (role.isLeft) {
      return Left(role.left);
    }
    return await roleRepository.deleteElement(t: role.right);
  }

  

}
