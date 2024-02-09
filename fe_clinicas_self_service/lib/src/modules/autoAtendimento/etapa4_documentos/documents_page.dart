import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_self_service/src/model/self_service_model.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/etapa4_documentos/widgets/document_box_widget.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/self_service_controller.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/widgets/clinica_self_service_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> with MessagesViewMixin {
  final selfServiceController = Injector.get<SelfServiceController>();

  @override
  void initState() {
    //como essa pagina documents n tem o contoller pode usar a do selfServiceController
    //tmb pq é a ultima
    messageListener(selfServiceController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final documents = selfServiceController.model.documents;
    final totalCarteirinha = documents?[DocumentType.carteirinha]?.length ?? 0;
    final totalPedidoMedico =
        documents?[DocumentType.pedidoMedico]?.length ?? 0;

    return Scaffold(
      appBar: ClinicaSelfServiceAppbar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 18),
            padding: const EdgeInsets.all(32),
            width: size.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ClinicasTheme.orangeColor),
            ),
            child: Column(
              children: [
                Image.asset('assets/images/folder.png'),
                const SizedBox(height: 24),
                const Text(
                  'Adicione os documentos!',
                  style: ClinicasTheme.titleSmallStyle,
                ),
                const SizedBox(height: 32),
                const Text(
                  'Selecione os documentos que deseja adicionar ao seu prontuário.',
                  style: ClinicasTheme.subtitleStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: size.width * 0.8,
                  height: 310,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DocumentBoxWidget(
                        uploaded: totalCarteirinha > 0,
                        icon: Image.asset('assets/images/id_card.png'),
                        labels: 'Cateirinha',
                        totalFiles: totalCarteirinha,
                        onTap: () async {
                          final filePath = await Navigator.of(context)
                              .pushNamed(
                                  '/self-service/etapa4DocumentosPage/scan');
                          if (filePath != null && filePath != '') {
                            selfServiceController.registerDocument(
                              DocumentType.carteirinha,
                              filePath.toString(),
                            );
                            setState(() {}); //so pra atualizar a tela
                          }
                        },
                      ),
                      const SizedBox(width: 30),
                      DocumentBoxWidget(
                        uploaded: totalPedidoMedico > 0,
                        icon: Image.asset('assets/images/document.png'),
                        labels: 'Pedido médico',
                        totalFiles: totalPedidoMedico,
                        onTap: () async {
                          final filePath = await Navigator.of(context)
                              .pushNamed(
                                  '/self-service/etapa4DocumentosPage/scan');
                          if (filePath != null && filePath != '') {
                            selfServiceController.registerDocument(
                              DocumentType.pedidoMedico,
                              filePath.toString(),
                            );
                            setState(() {});
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Visibility(
                  visible: totalPedidoMedico > 0 || totalCarteirinha > 0,
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            fixedSize: const Size.fromHeight(50),
                            side: const BorderSide(color: Colors.red),
                          ),
                          onPressed: () {
                            selfServiceController.clearDocuments();
                            setState(() {});
                          },
                          child: const Text('Remover Tudo'),
                        ),
                      ),
                      const SizedBox(width: 22),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ClinicasTheme.orangeColor,
                            fixedSize: const Size.fromHeight(50),
                          ),
                          onPressed: () async {
                            await selfServiceController.finalize();
                          },
                          child: const Text('Finalizar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
