import 'package:asyncstate/asyncstate.dart';
import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_self_service/src/services/user_login_service.dart';
import 'package:signals_flutter/signals_flutter.dart';

class LoginController with MessagesStateMixin {
  //pra mostrar mensagens de erro
  LoginController({
    required IUserLoginService userLoginService,
  }) : _userLoginService = userLoginService;

  final IUserLoginService _userLoginService;

  final _obscurePassword = signal(true);
  bool get obscurePassword => _obscurePassword(); //ou _obscurePassword.value

  void showHidePassword() => _obscurePassword.value = !_obscurePassword.value;

  final _logado = signal(false);
  bool get logado => _logado();

  Future<void> login(String email, String senha) async {
    final result = await _userLoginService.execute(email, senha).asyncLoader();

    switch (result) {
      case Left(value: ServiceEx(:final message)):
        showError(message);
      case Right(value: _):
        _logado.value = true;
    }
  }
}
