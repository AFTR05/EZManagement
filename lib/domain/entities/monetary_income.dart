import 'package:ezmanagement/domain/enum/payment_method_enum.dart';

class MonetaryIncome {
  final String id;
  final String date;
  final double amount;
  final PaymentMethodEnum paymentMethod;
  final String description;
  final String clientId;
  final String saleId;

  MonetaryIncome({
    required this.id,
    required this.date,
    required this.amount,
    required this.description,
    required this.paymentMethod,
    required this.clientId,
    required this.saleId,
  });

  @override
  String toString() {
    return 'MonetaryIncome(id: $id, date: $date, amount: $amount, date: $date, description: $description)';
  }
  
}