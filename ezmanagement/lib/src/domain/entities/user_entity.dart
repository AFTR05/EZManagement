import 'package:ezmanagement/src/domain/entities/entity_mixin.dart';
import 'package:ezmanagement/src/domain/enum/state_enum.dart';

class UserEntity with EntityMixin {
  final String uid;
  final String? name;
  final String? email;
  final String? roleId;
  final String? roleName;
  final StateEnum? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? lastLoginAt;

  UserEntity({
    required this.uid,
    this.name,
    this.email,
    this.roleId,
    this.roleName,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.lastLoginAt,
  });

  factory UserEntity.fromMap(Map<String, dynamic> map, String id) {
    return UserEntity(
      uid: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      roleId: map['roleId'] ?? '',
      roleName: map['roleName'] ?? '',
      status: StateEnum.values.firstWhere(
        (e) => e.toString().split('.').last == map['state'],
        orElse: () =>
            StateEnum.active,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'roleName': roleName,
      'roleId': roleId,
      'state': status.toString().split('.').last,
    };
  }

  @override
  String toString() {
    return 'UserEntity(id: $uid, name: $name, email: $email)';
  }
}
