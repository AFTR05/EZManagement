class RoleEntity {
  final String id;
  final String roleName;
  final String description;

  RoleEntity({
    required this.id,
    required this.roleName,
    required this.description,
  });

  @override
  String toString() {
    return 'RoleEntity(id: $id, name: $roleName, description: $description)';
  }
  
}