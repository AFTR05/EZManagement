import 'package:ezmanagement/src/domain/entities/entity_mixin.dart';
import 'package:ezmanagement/src/domain/enum/payment_method_enum.dart';

class MonetaryIncome with EntityMixin {
  final String id;
  final DateTime date;
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

  factory MonetaryIncome.fromMap(Map<String, dynamic> map, String id) {
    return MonetaryIncome(
      id: id,
      date: DateTime.tryParse(map['date'] ?? '') ?? DateTime.now(),
      amount: (map['amount'] as num?)?.toDouble() ?? 0.0,
      paymentMethod: PaymentMethodEnum.values.firstWhere(
        (e) => e.toString().split('.').last == map['paymentMethod'],
        orElse: () => PaymentMethodEnum.cash,
      ),
      description: map['description'] ?? '',
      clientId: map['clientId'] ?? '',
      saleId: map['saleId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'amount': amount,
      'paymentMethod': paymentMethod.toString().split('.').last,
      'description': description,
      'clientId': clientId,
      'saleId': saleId,
    };
  }

  @override
  String toString() {
    return 'MonetaryIncome(id: $id, date: $date, amount: $amount, description: $description)';
  }
}
