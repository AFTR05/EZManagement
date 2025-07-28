class ClientEntity {
  final String id;
  final String name;
  final String email;
  final String nit;
  final String direction;

  ClientEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.nit,
    required this.direction,
  });

  @override
  String toString() {
    return 'ClientEntity(id: $id, name: $name, email: $email)';
  }
  
}