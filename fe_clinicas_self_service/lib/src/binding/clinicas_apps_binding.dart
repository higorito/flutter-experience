import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_self_service/src/core/env.dart';
import 'package:flutter_getit/flutter_getit.dart';

class ClinicasAppsBinding extends ApplicationBindings {
  @override
  List<Bind<Object>> bindings() => [
        Bind.lazySingleton<RestClient>(
          (i) => RestClient(Env.backendBaseUrl),
        ),
      ];
}
