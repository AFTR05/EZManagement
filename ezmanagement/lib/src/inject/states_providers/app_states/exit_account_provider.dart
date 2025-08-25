
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exit_account_provider.g.dart';

@Riverpod(keepAlive: true)
class ExitAccountProvider  extends _$ExitAccountProvider{
  @override
  bool build() {
    return false;
  } 

  void exitEmployee() {
    state = true;
  }
}