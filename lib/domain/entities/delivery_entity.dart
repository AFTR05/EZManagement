import 'package:ezmanagement/domain/entities/entity_mixin.dart';

class DeliveryEntity with EntityMixin {
  final String id;
  final String saleId;
  final String deliveryAddress;
  final DateTime deliveryDate;
  final String status;
  final String userResponsibleId;
  final String observation;

  DeliveryEntity({
    required this.id,
    required this.saleId,
    required this.deliveryAddress,
    required this.deliveryDate,
    required this.status,
    required this.userResponsibleId,
    required this.observation,
  });

  factory DeliveryEntity.fromMap(Map<String, dynamic> map, String id) {
    return DeliveryEntity(
      id: id,
      saleId: map['saleId'] ?? '',
      deliveryAddress: map['deliveryAddress'] ?? '',
      deliveryDate: DateTime.tryParse(map['deliveryDate'] ?? '') ?? DateTime.now(),
      status: map['status'] ?? '',
      userResponsibleId: map['userResponsibleId'] ?? '',
      observation: map['observation'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'saleId': saleId,
      'deliveryAddress': deliveryAddress,
      'deliveryDate': deliveryDate.toIso8601String(),
      'status': status,
      'userResponsibleId': userResponsibleId,
      'observation': observation,
    };
  }

  @override
  String toString() {
    return 'DeliveryEntity(id: $id, saleId: $saleId, status: $status)';
  }
}
