import 'package:ezmanagement/domain/enum/materia_state.dart';

class MaterialInput {
  final String id;
  final DateTime date;
  final double stock;
  final MaterialState state;
  final String? batchNumber;
  final String materialId;
  final String supplierId;
  final String userId;

  MaterialInput({
    required this.id,
    required this.stock,
    required this.date,
    required this.state,
    required this.materialId,
    required this.supplierId,
    required this.userId,
    this.batchNumber,
  });
}
