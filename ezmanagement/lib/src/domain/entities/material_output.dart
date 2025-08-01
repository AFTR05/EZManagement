
import 'package:ezmanagement/src/domain/entities/entity_mixin.dart';

class MaterialOutput with EntityMixin {
  final String id;
  final DateTime date;
  final double stock;
  final String userResponsibleId;
  final String materialId;
  final String projectId;
  final String justification;

  MaterialOutput({
    required this.id,
    required this.date,
    required this.stock,
    required this.userResponsibleId,
    required this.materialId,
    required this.projectId,
    required this.justification,
  });

  factory MaterialOutput.fromMap(Map<String, dynamic> map, String id) {
    return MaterialOutput(
      id: id,
      date: DateTime.tryParse(map['date'] ?? '') ?? DateTime.now(),
      stock: (map['stock'] as num?)?.toDouble() ?? 0.0,
      userResponsibleId: map['userResponsibleId'] ?? '',
      materialId: map['materialId'] ?? '',
      projectId: map['projectId'] ?? '',
      justification: map['justification'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'stock': stock,
      'userResponsibleId': userResponsibleId,
      'materialId': materialId,
      'projectId': projectId,
      'justification': justification,
    };
  }

  @override
  String toString() {
    return 'MaterialOutput(id: $id, materialId: $materialId, stock: $stock, projectId: $projectId)';
  }
}
