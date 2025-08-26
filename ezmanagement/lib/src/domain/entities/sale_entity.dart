import 'package:ezmanagement/src/domain/entities/entity_mixin.dart';
import 'package:ezmanagement/src/domain/entities/sale_detail_entity.dart';
import 'package:ezmanagement/src/domain/enum/payment_method_enum.dart';

class SaleEntity with EntityMixin {
  final String id;
  final DateTime saleDate;
  final PaymentMethodEnum paymentMethod;
  final double totalAmount;
  final String clientId;
  final String sellerId;
  final List<SaleDetailEntity> details;

  const SaleEntity({
    required this.id,
    required this.clientId,
    required this.saleDate,
    required this.totalAmount,
    required this.sellerId,
    required this.paymentMethod,
    required this.details,
  });

  factory SaleEntity.fromMap(Map<String, dynamic> map, String id) {
    return SaleEntity(
      id: id,
      clientId: (map['clientId'] as String?)?.trim() ?? '',
      saleDate: _parseDate(map['saleDate']) ?? DateTime.now(),
      totalAmount: (map['totalAmount'] as num?)?.toDouble() ?? 0.0,
      sellerId: (map['sellerId'] as String?)?.trim() ?? '',
      paymentMethod: _parsePaymentMethod(map['paymentMethod']),
      details: _parseDetails(map['details'], id),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clientId': clientId,
      'saleDate': saleDate.toIso8601String(),
      'totalAmount': totalAmount,
      'sellerId': sellerId,
      'paymentMethod': paymentMethod.name,
      'details': details.map((e) => e.toMap()).toList(),
    };
  }

  @override
  String toString() {
    return 'SaleEntity(id: $id, paymentMethod: ${paymentMethod.name}, '
        'saleDate: $saleDate, totalAmount: $totalAmount, '
        'sellerId: $sellerId, clientId: $clientId, details: ${details.length})';
  }

  // ----------------- Helpers -----------------

  static DateTime? _parseDate(dynamic raw) {
    if (raw == null) return null;
    if (raw is DateTime) return raw;
    if (raw is int) {
      // epoch ms
      return DateTime.fromMillisecondsSinceEpoch(raw, isUtc: true).toLocal();
    }
    if (raw is String && raw.isNotEmpty) {
      return DateTime.tryParse(raw);
    }
    // Soporte básico a Timestamp serializado (Firestore-like)
    if (raw is Map && raw.containsKey('_seconds')) {
      final seconds = (raw['_seconds'] as num?)?.toInt();
      final nanos = (raw['_nanoseconds'] as num?)?.toInt() ?? 0;
      if (seconds != null) {
        final ms = seconds * 1000 + (nanos / 1e6).round();
        return DateTime.fromMillisecondsSinceEpoch(ms, isUtc: true).toLocal();
      }
    }
    return null;
  }

  static PaymentMethodEnum _parsePaymentMethod(dynamic raw) {
    if (raw == null) return PaymentMethodEnum.cash;
    final s = raw.toString().trim().toLowerCase();
    for (final e in PaymentMethodEnum.values) {
      if (e.name.toLowerCase() == s) return e;
      if (e.toString().toLowerCase().split('.').last == s) return e;
    }
    return PaymentMethodEnum.cash;
  }

  static List<SaleDetailEntity> _parseDetails(dynamic raw, String saleId) {
    if (raw is List) {
      return raw
          .whereType<Map>()
          .map((e) {
            // Inyecta saleId si no viene
            final m = Map<String, dynamic>.from(e.cast<String, dynamic>());
            m['saleId'] = (m['saleId'] as String?)?.trim().isNotEmpty == true
                ? m['saleId']
                : saleId;

            // Si quieres generar un ID compuesto utilízalo aquí:
            final composedId =
                '${m['saleId']}_${(m['productId'] ?? '').toString()}';

            return SaleDetailEntity.fromMap(m, composedId);
          })
          .toList();
    }
    return const <SaleDetailEntity>[];
  }
}
