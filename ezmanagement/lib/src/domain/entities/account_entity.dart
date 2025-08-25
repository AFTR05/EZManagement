
import 'package:ezmanagement/src/domain/entities/entity_mixin.dart';
import 'package:ezmanagement/src/domain/enum/auth_provider_enum.dart';

class AccountEntity with EntityMixin {
  final String uid;
  final String? idToken;
  final DateTime? expiresAt;
  final Set<AuthProviderEnum> providers;
  final bool isAuthenticated;

  AccountEntity({
    required this.uid,
    this.idToken,
    this.expiresAt,
    this.providers = const {AuthProviderEnum.password},
    this.isAuthenticated = false,
  });
}
