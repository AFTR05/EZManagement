import 'package:ezmanagement/domain/entities/user_entity.dart';

class DeliveryEntity {
  final String id;
  final String saleId;
  final String deliveryAddress;
  final DateTime deliveryDate;
  final String status;
  final UserEntity userResponsible;
  final String observation;


  DeliveryEntity({
    required this.id,
    required this.saleId,
    required this.deliveryAddress,
    required this.deliveryDate,
    required this.status,
    required this.userResponsible,
    required this.observation,
  });
  
}