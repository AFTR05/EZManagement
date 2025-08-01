import 'package:ezmanagement/src/domain/entities/entity_mixin.dart';
import 'package:ezmanagement/src/domain/entities/role_entity.dart';
import 'package:ezmanagement/src/domain/enum/state_enum.dart';

class UserEntity with EntityMixin {
  final String id;
  final String name;
  final String email;
  final String password;
  final RoleEntity role;
  final StateEnum state;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.state,
  });

  factory UserEntity.fromMap(Map<String, dynamic> map, String id) {
    return UserEntity(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      role: RoleEntity.fromMap(Map<String, dynamic>.from(map['role'] ?? {}), map['roleId'] ?? ''),
      state: StateEnum.values.firstWhere(
        (e) => e.toString().split('.').last == map['state'],
        orElse: () => StateEnum.active, // Ajusta si tu enum tiene otro valor por defecto
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'role': role.toMap(),
      'roleId': role.id,
      'state': state.toString().split('.').last,
    };
  }

  @override
  String toString() {
    return 'UserEntity(id: $id, name: $name, email: $email)';
  }
}
