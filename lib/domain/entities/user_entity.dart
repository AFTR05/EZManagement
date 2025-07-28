import 'package:ezmanagement/domain/entities/role_entity.dart';
import 'package:ezmanagement/domain/enum/state_enum.dart';

class UserEntity {
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

  @override
  String toString() {
    return 'UserEntity(id: $id, name: $name, email: $email)';
  }
  
}