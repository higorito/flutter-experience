import 'package:fe_clinicas_self_service/src/modules/auth/login/login_router.dart';
import 'package:fe_clinicas_self_service/src/repositories/user/user_repository.dart';
import 'package:fe_clinicas_self_service/src/repositories/user/user_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class AuthModule extends FlutterGetItModule {
  //esses binds vao ser usados em todas paginas q estiverem dentro do modulo
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<IUserRepository>(
            (i) => UserRepositoryImpl(restClient: i()))
      ];

  @override
  String get moduleRouteName => '/auth';

  @override
  Map<String, WidgetBuilder> get pages => {'/login': (_) => LoginRouter()};
}
