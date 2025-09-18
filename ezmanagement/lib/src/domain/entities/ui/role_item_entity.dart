
import 'package:ezmanagement/src/domain/entities/entity_mixin.dart';
import 'package:ezmanagement/src/domain/entities/role_entity.dart';
import 'package:ezmanagement/src/domain/entities/user_entity.dart';

class RoleItemEntity with EntityMixin {
  final RoleEntity role;
  final List<UserEntity> users;

  RoleItemEntity({
    required this.role,
    required this.users
  });
}
