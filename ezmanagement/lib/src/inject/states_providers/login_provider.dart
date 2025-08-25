import 'package:ezmanagement/src/domain/entities/account_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_provider.g.dart';

@Riverpod(keepAlive: true)
class LoginProvider extends _$LoginProvider {
  @override
  AccountEntity? build() {
    return null;
  }

  void setState(AccountEntity? newValue) {
    state = newValue;
  }
}
