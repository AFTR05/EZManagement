import 'package:ezmanagement/src/domain/entities/entity_mixin.dart';

class ClientEntity with EntityMixin {
  final String id;
  final String name;
  final String email;
  final String telephone;
  final String nit;
  final String direction;

  ClientEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.nit,
    required this.direction,
    required this.telephone
  });

  factory ClientEntity.fromMap(Map<String, dynamic> map, String id) {
    return ClientEntity(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      nit: map['nit'] ?? '',
      direction: map['direction'] ?? '',
      telephone: map['telephone'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'nit': nit,
      'direction': direction,
    };
  }

  @override
  String toString() {
    return 'ClientEntity(id: $id, name: $name, email: $email)';
  }
}
