
import 'package:ezmanagement/domain/entities/entity_mixin.dart';

class SupplierEntity with EntityMixin {
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

  factory SupplierEntity.fromMap(Map<String, dynamic> map, String id) {
    return SupplierEntity(
      id: id,
      name: map['name'] ?? '',
      contactInfo: map['contactInfo'] ?? '',
      state: map['state'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'contactInfo': contactInfo,
      'state': state,
    };
  }

  @override
  String toString() {
    return 'SupplierEntity(id: $id, name: $name, contactInfo: $contactInfo)';
  }
}
