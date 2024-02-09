import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/done/done_page.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/etapa1Nomes/etapa1_nomes_page.dart';

import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/etapa2Paciente/find_paciente_router.dart';

import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/etapa3ValPaciente/valpatiente_router.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/etapa4_documentos/documents_page.dart';

import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/etapa4_documentos/scan/documentos_scan_page.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/etapa4_documentos/scanConfirm/documents_scan_confirm_router.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/self_service_controller.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/self_service_page.dart';
import 'package:fe_clinicas_self_service/src/repositories/patients/patient_repository.dart';
import 'package:fe_clinicas_self_service/src/repositories/patients/patient_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class SelfServiceModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        //tudo vai ter acesso a esse controller
        Bind.lazySingleton((_) => SelfServiceController()),
        //como o PatienteRepositoryImpl vai ser usado em mais de um lugar subi ele de nivel
        Bind.lazySingleton<IPatientRepository>(
            (i) => PatienteRepositoryImpl(restClient: i())),
      ];

  @override
  String get moduleRouteName => '/self-service';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (context) => const SelfServicePage(),
        '/etapa1NomesPage': (context) => const Etapa1NomesPage(),
        '/Etapa2PacientePage': (context) => const FindPacienteRouter(),
        '/etapa3ValPacientePage': (context) => const ValPatienteRouter(),
        '/etapa4DocumentosPage': (context) => const DocumentsPage(),
        '/etapa4DocumentosPage/scan': (context) => const DocumentosScanPage(),
        '/etapa4DocumentosPage/scan/confirm': (context) =>
            const DocumentsScanConfirmRouter(),
        '/donePage': (context) => const DonePage(),
      };
}
