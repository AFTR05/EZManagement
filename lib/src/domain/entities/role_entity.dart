
import 'package:ezmanagement/src/domain/entities/entity_mixin.dart';

class RoleEntity with EntityMixin {
  final String id;
  final String roleName;
  final String description;

  RoleEntity({
    required this.id,
    required this.roleName,
    required this.description,
  });

  factory RoleEntity.fromMap(Map<String, dynamic> map, String id) {
    return RoleEntity(
      id: id,
      roleName: map['roleName'] ?? '',
      description: map['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'roleName': roleName,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'RoleEntity(id: $id, name: $roleName, description: $description)';
  }
}
