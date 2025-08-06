import 'package:ezmanagement/src/domain/entities/entity_mixin.dart';

class DeliveryEntity with EntityMixin {
  final String id;
  final String name;
  final String email;
  final String nit;
  final String direction;

  DeliveryEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.nit,
    required this.direction,
  });

  factory DeliveryEntity.fromMap(Map<String, dynamic> map, String id) {
    return DeliveryEntity(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      nit: map['nit'] ?? '',
      direction: map['direction'] ?? '',
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
