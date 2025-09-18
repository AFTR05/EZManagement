import 'package:ezmanagement/src/domain/entities/role_entity.dart';
import 'package:ezmanagement/src/domain/enum/permission_enum.dart';
import 'package:ezmanagement/src/domain/usecases/role_usecase.dart';

class RoleController {
  final RoleUsecase _roleUsecase;
  RoleController({required RoleUsecase roleUsecase})
    : _roleUsecase = roleUsecase;

  Future<List<RoleEntity>> getRoles() async {
    final result = await _roleUsecase.getRoles();
    if (result.isRight) {
      return result.right;
    }
    return [];
  }

  Future<void> createRole({
    required String roleName,
    required String description,
    required List<PermissionEnum> permissions,
  }) async {
    await _roleUsecase.createRole(
      description: description,
      permissions: permissions,
      roleName: roleName,
    );
    //TODO: Manejo de errores
  }

  Stream<List<RoleEntity>> watchAllElements() {
    return _roleUsecase.watchAllElements().map(
      (either) => either.fold((_) => const <RoleEntity>[], (list) => list),
    );
  }

  Future<void> updateRole({
    required String id,
    required String roleName,
    required String description,
    required List<PermissionEnum> permissions,
  }) async {
    await _roleUsecase.updateRole(
      id: id,
      roleName: roleName,
      description: description,
      permissions: permissions,
    );
  }

  Future<void> deleteRole({required String id}) async {
    await _roleUsecase.deleteRole(id: id);
  }
}
