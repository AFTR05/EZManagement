
import 'package:ezmanagement/src/domain/entities/entity_mixin.dart';

class SaleDetailEntity with EntityMixin {
  final String productId;
  final String saleId;
  final double stock;
  final double unitPrice;

  SaleDetailEntity({
    required this.productId,
    required this.saleId,
    required this.stock,
    required this.unitPrice,
  });

  factory SaleDetailEntity.fromMap(Map<String, dynamic> map, String id) {
    // 'id' podría ser útil si decides usar un ID compuesto como 'saleId_productId'
    return SaleDetailEntity(
      productId: map['productId'] ?? '',
      saleId: map['saleId'] ?? '',
      stock: (map['stock'] as num?)?.toDouble() ?? 0.0,
      unitPrice: (map['unitPrice'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'saleId': saleId,
      'stock': stock,
      'unitPrice': unitPrice,
    };
  }

  @override
  String toString() {
    return 'SaleDetailEntity(productId: $productId, saleId: $saleId, stock: $stock, unitPrice: $unitPrice)';
  }
}
