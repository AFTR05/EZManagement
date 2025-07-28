class MaterialEntity {
  final String id;
  final String name;
  final String type;

  MaterialEntity({
    required this.id,
    required this.name,
    required this.type,
  });

  @override
  String toString() {
    return 'MaterialEntity(id: $id, name: $name, description: $type)';
  }
  
}