
import 'package:ezmanagement/src/domain/entities/entity_mixin.dart';

class ProductEntity with EntityMixin {
  final String id;
  final String name;
  final String description;
  final double unitPrice;
  final String category;
  final double stock;
  final double measure;

  ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.unitPrice,
    required this.category,
    required this.stock,
    required this.measure,
  });

  factory ProductEntity.fromMap(Map<String, dynamic> map, String id) {
    return ProductEntity(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      unitPrice: (map['unitPrice'] as num?)?.toDouble() ?? 0.0,
      category: map['category'] ?? '',
      stock: (map['stock'] as num?)?.toDouble() ?? 0.0,
      measure: (map['measure'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'unitPrice': unitPrice,
      'category': category,
      'stock': stock,
      'measure': measure,
    };
  }

  @override
  String toString() {
    return 'ProductEntity(id: $id, name: $name, description: $description, price: $unitPrice, category: $category)';
  }
}
