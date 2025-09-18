
import 'package:ezmanagement/src/domain/entities/entity_mixin.dart';

class RoleEntity with EntityMixin {
  final String id;
  final String roleName;
  final String description;
  final List<String> permissions;

  RoleEntity({
    required this.id,
    required this.roleName,
    required this.description,
    required this.permissions,
  });

  factory RoleEntity.fromMap(Map<String, dynamic> map, String id) {
    final raw = map['permissions'];

    final perms = raw is Iterable
        ? raw.map((e) => e.toString()).toList(growable: false)
        : const <String>[];

    return RoleEntity(
      id: id,
      roleName: (map['roleName'] ?? '').toString(),
      description: (map['description'] ?? '').toString(),
      permissions: perms,
    );
  }

  Map<String, dynamic> toMap() => {
        'roleName': roleName,
        'description': description,
        'permissions': List<String>.from(permissions),
      };
}
