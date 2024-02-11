import 'package:fe_clinicas_core/fe_clinicas_core.dart';

import 'package:flutter_getit/flutter_getit.dart';

import '../core/env.dart';

class ClinicaAppBinding extends ApplicationBindings {
  @override
  List<Bind<Object>> bindings() => [
        Bind.lazySingleton<RestClient>(
          (i) => RestClient(Env.backendBaseUrl),
        ),
      ];
}
