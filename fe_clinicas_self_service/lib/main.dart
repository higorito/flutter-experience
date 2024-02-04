import 'dart:async';
import 'dart:developer';

import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_self_service/src/binding/clinicas_apps_binding.dart';
import 'package:fe_clinicas_self_service/src/modules/auth/auth_module.dart';
import 'package:fe_clinicas_self_service/src/modules/home/home_module.dart';
import 'package:fe_clinicas_self_service/src/pages/splashPage/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

void main() {
  runZonedGuarded(() {
    runApp(const ClinicasSelfServiceApp());
  }, (error, stack) {
    log('ERROR NAO TRATADO', error: error, stackTrace: stack);
    throw error;
  });
}

class ClinicasSelfServiceApp extends StatelessWidget {
  const ClinicasSelfServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ClinicasCoreConfig(
      title: 'Auto Atendimento',
      binding:
          ClinicasAppsBinding(), //bind q vai ser injetado no getit com a instancia do restclient que passa a url do backend (restclient disponivel pro app todo)
      pagesBuilders: [
        FlutterGetItPageBuilder(page: (_) => const SplashPage(), path: '/'),
      ],
      modules: [
        AuthModule(),
        HomeModule(),
      ],
    );
  }
}
