class SupplierEntity {
  final String id;
  final String name;
  final String contactInfo;
  final String state;

  SupplierEntity({
    required this.id,
    required this.name,
    required this.contactInfo,
    required this.state,
  });

  @override
  String toString() {
    return 'SupplierEntity(id: $id, name: $name, contactInfo: $contactInfo)';
  }
  
}