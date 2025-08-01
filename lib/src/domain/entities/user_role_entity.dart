import 'package:ezmanagement/src/domain/entities/entity_mixin.dart';

class UserRoleEntity with EntityMixin {
  final String userId;
  final String roleId;
  final String permissionId;
  final DateTime beginDate;
  final DateTime? endDate;
  final String justification;

  UserRoleEntity({
    required this.userId,
    required this.roleId,
    required this.permissionId,
    required this.beginDate,
    required this.endDate,
    required this.justification,
  });

  factory UserRoleEntity.fromMap(Map<String, dynamic> map, String id) {
    return UserRoleEntity(
      userId: map['userId'] ?? '',
      roleId: map['roleId'] ?? '',
      permissionId: map['permissionId'] ?? '',
      beginDate: DateTime.tryParse(map['beginDate'] ?? '') ?? DateTime.now(),
      endDate: map['endDate'] != null ? DateTime.tryParse(map['endDate']) : null,
      justification: map['justification'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'roleId': roleId,
      'permissionId': permissionId,
      'beginDate': beginDate.toIso8601String(),
      if (endDate != null) 'endDate': endDate!.toIso8601String(),
      'justification': justification,
    };
  }

  @override
  String toString() {
    return 'UserRoleEntity(userId: $userId, roleId: $roleId, permissionId: $permissionId)';
  }
}
