import 'package:ezmanagement/domain/entities/entity_mixin.dart';
import 'package:ezmanagement/domain/enum/payment_method_enum.dart';
class SaleEntity with EntityMixin {
  final String id;
  final DateTime saleDate;
  final PaymentMethodEnum paymentMethod;
  final double totalAmount;
  final String clientId;
  final String sellerId;

  SaleEntity({
    required this.id,
    required this.clientId,
    required this.saleDate,
    required this.totalAmount,
    required this.sellerId,
    required this.paymentMethod,
  });

  factory SaleEntity.fromMap(Map<String, dynamic> map, String id) {
    return SaleEntity(
      id: id,
      clientId: map['clientId'] ?? '',
      saleDate: DateTime.tryParse(map['saleDate'] ?? '') ?? DateTime.now(),
      totalAmount: (map['totalAmount'] as num?)?.toDouble() ?? 0.0,
      sellerId: map['sellerId'] ?? '',
      paymentMethod: PaymentMethodEnum.values.firstWhere(
        (e) => e.toString().split('.').last == map['paymentMethod'],
        orElse: () => PaymentMethodEnum.cash,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clientId': clientId,
      'saleDate': saleDate.toIso8601String(),
      'totalAmount': totalAmount,
      'sellerId': sellerId,
      'paymentMethod': paymentMethod.toString().split('.').last,
    };
  }

  @override
  String toString() {
    return 'SaleEntity(id: $id, paymentMethod: $paymentMethod, saleDate: $saleDate, totalAmount: $totalAmount, sellerId: $sellerId)';
  }
}
