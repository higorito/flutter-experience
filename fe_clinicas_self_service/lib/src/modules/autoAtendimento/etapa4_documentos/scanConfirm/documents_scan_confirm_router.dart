import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/etapa4_documentos/scanConfirm/documents_scan_confirm_controller.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/etapa4_documentos/scanConfirm/documents_scan_confirm_page.dart';
import 'package:fe_clinicas_self_service/src/repositories/documents/documents_repository.dart';
import 'package:fe_clinicas_self_service/src/repositories/documents/documents_repository_impl.dart';
import 'package:flutter/material.dart';

import 'package:flutter_getit/flutter_getit.dart';

class DocumentsScanConfirmRouter extends FlutterGetItModulePageRouter {
  const DocumentsScanConfirmRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<IDocumentsRepository>(
            (i) => DocumentsRepositoryImpl(restClient: i())),
        Bind.lazySingleton(
            (i) => DocumentsScanConfirmController(documentsRepository: i())),

        //so vai ser usado aqui esse repository q cuida de documentos
      ];

  @override
  WidgetBuilder get view => (_) => DocumentosScanConfirmPage();
}
