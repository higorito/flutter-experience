import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

import '../../repositories/user/user_repository.dart';
import '../../repositories/user/user_repository_impl.dart';
import '../../service/login/user_login_service.dart';
import '../../service/login/user_login_service_impl.dart';

import 'login_controller.dart';
import 'login_page.dart';

class LoginRouter extends FlutterGetItPageRouter {
  const LoginRouter({super.key});

  @override
  String get routeName => '/login';

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<IUserRepository>(
            (i) => UserRepositoryImpl(restClient: i())),
        Bind.lazySingleton<IUserLoginService>(
          (i) => UserLoginServiceImpl(
              userRepository:
                  i()), //como userRepository ta la no modulo ele vai ser injetado aqui automaticamente
        ),
        Bind.lazySingleton((i) => LoginController(userLoginService: i())),
      ];

  @override
  WidgetBuilder get view => (_) => const LoginPage();
}
