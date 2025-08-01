
import 'package:ezmanagement/domain/entities/entity_mixin.dart';

class PermissionEntity with EntityMixin {
  final String id;
  final String name;
  final String module;

  PermissionEntity({
    required this.id,
    required this.name,
    required this.module,
  });

  factory PermissionEntity.fromMap(Map<String, dynamic> map, String id) {
    return PermissionEntity(
      id: id,
      name: map['name'] ?? '',
      module: map['module'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'module': module,
    };
  }

  @override
  String toString() {
    return 'PermissionEntity(id: $id, name: $name, module: $module)';
  }
}
