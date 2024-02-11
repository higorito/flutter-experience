import 'dart:async';
import 'dart:developer';

import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_desktop/src/bindings/clinica_app_binding.dart';
import 'package:fe_clinicas_desktop/src/pages/checkin/checkin_router.dart';
import 'package:fe_clinicas_desktop/src/pages/home/home_router.dart';
import 'package:fe_clinicas_desktop/src/pages/login/login_router.dart';
import 'package:fe_clinicas_desktop/src/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

import 'src/pages/pre_checkin/pre_checkin_router.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding
        .ensureInitialized(); //garante que o flutter esteja inicializado
    runApp(const ClinicasAdm());
  }, (error, stack) {
    log('ERROR NAO TRATADO', error: error, stackTrace: stack);
    throw error;
  });
}

class ClinicasAdm extends StatelessWidget {
  const ClinicasAdm({super.key});

  @override
  Widget build(BuildContext context) {
    return ClinicasCoreConfig(
      title: 'Clinicas Administrador',
      pagesBuilders: [
        FlutterGetItPageBuilder(page: (_) => const SplashPage(), path: '/'),
      ],
      binding: ClinicaAppBinding(), //repasssando o binding

      //aqui no desktop n é modules vão ser paginas simples
      //muda so o extends do router e o caminho
      pages: const [
        LoginRouter(),
        HomeRouter(),
        PreCheckinRouter(),
        CheckinRouter(),
      ],
    );
  }
}
