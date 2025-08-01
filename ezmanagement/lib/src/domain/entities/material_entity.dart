
import 'package:ezmanagement/src/domain/entities/entity_mixin.dart';

class MaterialEntity with EntityMixin {
  final String id;
  final String name;
  final String type;

  MaterialEntity({
    required this.id,
    required this.name,
    required this.type,
  });

  factory MaterialEntity.fromMap(Map<String, dynamic> map, String id) {
    return MaterialEntity(
      id: id,
      name: map['name'] ?? '',
      type: map['type'] ?? '',
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
