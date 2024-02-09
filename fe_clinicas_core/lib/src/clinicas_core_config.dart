import 'package:asyncstate/asyncstate.dart';
import 'package:fe_clinicas_core/src/loader/clinicas_loader.dart';
import 'package:fe_clinicas_core/src/theme/clinicas_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class ClinicasCoreConfig extends StatelessWidget {
  const ClinicasCoreConfig({
    super.key,
    this.binding,
    this.pages,
    this.pagesBuilders,
    this.modules,
    required this.title,
    this.didStart,
  });

  final ApplicationBindings?
      binding; //tipo o modular msm, bindindo é para injetar dependencias. bindindo de aplicação nao morre nunca

  //pode ser pagesbuilders, routes e modules

  final List<FlutterGetItPageRouter>? pages;

  final List<FlutterGetItPageBuilder>? pagesBuilders;

  final List<FlutterGetItModule>? modules;

  final String title;

  final VoidCallback?
      didStart; //camera e outras coisas que precisam ser inicializadas antes de iniciar o app

  @override
  Widget build(BuildContext context) {
    return FlutterGetIt(
      debugMode: true,
      bindings: binding,
      // bindingsBuilder: () => [Bind.lazySingleton((i) => 'TESTE')],
      pages: [...pages ?? [], ...pagesBuilders ?? []],
      modules: modules,
      builder: (context, routes, flutterGetItNavObserver) {
        return AsyncStateBuilder(
          //pq asyncstate? pq ele é um builder de estado, e o builder de estado é o que o flutter usa para construir a tela
          //ai vamos usar pq tem o loading customizado
          loader: ClinicasLoader(),
          builder: (navigatorObserver) {
            if (didStart != null) {
              didStart!();
            }
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ClinicasTheme.lightTheme,
              navigatorObservers: [
                navigatorObserver,
                flutterGetItNavObserver
              ], //para entender a questao de modulo
              routes: routes,
              title: title,
            );
          },
        );
      },
    );
  }
}
