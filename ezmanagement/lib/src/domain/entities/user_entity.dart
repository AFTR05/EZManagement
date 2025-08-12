import 'package:ezmanagement/src/domain/entities/entity_mixin.dart';
import 'package:ezmanagement/src/domain/enum/state_enum.dart';

class UserEntity with EntityMixin {
  final String id;
  final String name;
  final String email;
  final String roleId;
  final String roleName;
  final StateEnum state;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.roleId,
    required this.roleName,
    required this.state,
  });

  factory UserEntity.fromMap(Map<String, dynamic> map, String id) {
    return UserEntity(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      roleId: map['roleId'] ?? '',
      roleName: map['roleName'] ?? '',
      state: StateEnum.values.firstWhere(
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
      'state': state.toString().split('.').last,
    };
  }

  @override
  String toString() {
    return 'UserEntity(id: $id, name: $name, email: $email)';
  }
}
