class UserRoleEntity {
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
}
