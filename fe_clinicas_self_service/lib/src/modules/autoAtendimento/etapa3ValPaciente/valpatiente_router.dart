import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/etapa3ValPaciente/etapa3_val_paciente_page.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/etapa3ValPaciente/valpatiente_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class ValPatienteRouter extends FlutterGetItModulePageRouter {
  const ValPatienteRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton(
            (i) => ValPatienteController(patientRepository: i())),
      ];

  @override
  WidgetBuilder get view => (_) => const Etapa3ValPacientePage();
}
