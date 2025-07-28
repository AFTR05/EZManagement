class ProductEntity {
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

  @override
  String toString() {
    return 'ProductEntity(id: $id, name: $name, description: $description, price: $unitPrice, category: $category)';
  }
}