import 'package:fe_clinicas_painel/src/pages/painel/painel_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_getit/flutter_getit.dart';

import '../../repositories/painel_checkin/painel_checkin_repository.dart';
import '../../repositories/painel_checkin/painel_checkin_repository_impl.dart';
import 'painel_controller.dart';

class PainelRouter extends FlutterGetItPageRouter {
  const PainelRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<IPainelCheckinRepository>(
          (i) => PainelCheckinRepositoryImpl(restClient: i()),
        ),
        Bind.lazySingleton(
          (i) => PainelCotroller(painelCheckinRepository: i()),
        ),
      ];

  @override
  String get routeName => '/painel';

  @override
  WidgetBuilder get view => (_) => const PainelPage();
}
