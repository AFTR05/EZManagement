import 'package:ezmanagement/domain/enum/payment_method_enum.dart';

class SaleEntity {
  final String id;
  final String saleDate;
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

  @override
  String toString() {
    return 'SaleEntity(id: $id, paymentMethod: $paymentMethod, saleDate: $saleDate, totalAmount: $totalAmount, sellerId: $sellerId)';
  }
  
}