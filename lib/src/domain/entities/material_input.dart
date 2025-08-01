import 'package:ezmanagement/src/domain/entities/entity_mixin.dart';
import 'package:ezmanagement/src/domain/enum/materia_state.dart';
class MaterialInput with EntityMixin {
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

  factory MaterialInput.fromMap(Map<String, dynamic> map, String id) {
    return MaterialInput(
      id: id,
      stock: (map['stock'] as num?)?.toDouble() ?? 0.0,
      date: DateTime.tryParse(map['date'] ?? '') ?? DateTime.now(),
      state: MaterialState.values.firstWhere(
        (e) => e.toString().split('.').last == map['state'],
        orElse: () => MaterialState.pending, // Ajusta según tu enum
      ),
      batchNumber: map['batchNumber'],
      materialId: map['materialId'] ?? '',
      supplierId: map['supplierId'] ?? '',
      userId: map['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'stock': stock,
      'date': date.toIso8601String(),
      'state': state.toString().split('.').last,
      if (batchNumber != null) 'batchNumber': batchNumber,
      'materialId': materialId,
      'supplierId': supplierId,
      'userId': userId,
    };
  }

  @override
  String toString() {
    return 'MaterialInput(id: $id, materialId: $materialId, stock: $stock, state: $state)';
  }
}
