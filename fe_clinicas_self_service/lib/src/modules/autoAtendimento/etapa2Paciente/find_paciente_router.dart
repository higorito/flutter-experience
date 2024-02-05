import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/etapa2Paciente/etapa2_paciente_page.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/etapa2Paciente/patient_controller.dart';
import 'package:flutter/material.dart';

import 'package:flutter_getit/flutter_getit.dart';

class FindPacienteRouter extends FlutterGetItModulePageRouter {
  const FindPacienteRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton((i) => PatientController(patientRepository: i())),
      ];

  @override
  WidgetBuilder get view => (_) => const Etapa2PacientePage();
}
