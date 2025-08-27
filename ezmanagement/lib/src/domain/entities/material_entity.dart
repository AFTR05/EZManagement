
import 'package:ezmanagement/src/domain/entities/entity_mixin.dart';

class MaterialEntity with EntityMixin {
  final String id;
  final String name;
  final String type;
  final double stock;
  final String description;
  final double unitPrice;

  MaterialEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.stock,
    required this.description,
    required this.unitPrice,
  });

  factory MaterialEntity.fromMap(Map<String, dynamic> map, String id) {
    return MaterialEntity(
      id: id,
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      stock: map['stock'] != null ? (map['stock'] as num).toDouble() : 0.0,
      description: map['measure'] ?? '',
      unitPrice: map['unitPrice'] != null ? (map['unitPrice'] as num).toDouble() : 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
    };
  }

  @override
  String toString() {
    return 'MaterialEntity(id: $id, name: $name, type: $type)';
  }
}
