class PermissionEntity {
  final String id;
  final String name;
  final String module;

  PermissionEntity({
    required this.id,
    required this.name,
    required this.module,
  });

  @override
  String toString() {
    return 'PermissionEntity(id: $id, name: $name, description: $module)';
  }
  
}