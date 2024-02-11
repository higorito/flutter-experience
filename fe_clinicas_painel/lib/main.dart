import 'dart:async';
import 'dart:developer';

import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_painel/src/pages/login/login_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

import 'src/bindings/clinica_app_binding.dart';
import 'src/pages/painel/painel_router.dart';
import 'src/pages/splash/splash_page.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding
        .ensureInitialized(); //garante que o flutter esteja inicializado
    runApp(const ClinicasPainelApp());
  }, (error, stack) {
    log('ERROR NAO TRATADO', error: error, stackTrace: stack);
    throw error;
  });
}

class ClinicasPainelApp extends StatelessWidget {
  const ClinicasPainelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ClinicasCoreConfig(
      title: 'Clinicas Painel',
      binding: ClinicaAppBinding(),
      pagesBuilders: [
        FlutterGetItPageBuilder(page: (_) => const SplashPage(), path: '/'),
      ],
      pages: const [
        LoginRouter(),
        PainelRouter(),
      ],
    );
  }
}
