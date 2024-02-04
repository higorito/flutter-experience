import 'package:fe_clinicas_self_service/src/modules/auth/login/login_controller.dart';
import 'package:fe_clinicas_self_service/src/modules/auth/login/login_page.dart';
import 'package:fe_clinicas_self_service/src/services/user_login_service.dart';
import 'package:fe_clinicas_self_service/src/services/user_login_service_impl.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_getit/flutter_getit.dart';

class LoginRouter extends FlutterGetItModulePageRouter {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<IUserLoginService>(
          (i) => UserLoginServiceImpl(
              userRepository:
                  i()), //como userRepository ta la no modulo ele vai ser injetado aqui automaticamente
        ),
        Bind.lazySingleton((i) => LoginController(userLoginService: i())),
      ];

  @override
  WidgetBuilder get view => (_) => LoginPage();
}
