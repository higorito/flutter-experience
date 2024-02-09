import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/etapa4_documentos/scanConfirm/documents_scan_confirm_controller.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/widgets/clinica_self_service_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';

class DocumentosScanConfirmPage extends StatelessWidget {
  DocumentosScanConfirmPage({super.key});

  late CameraController cameraController;

  //aquela controller do documento
  final controller = Injector.get<DocumentsScanConfirmController>();

  @override
  Widget build(BuildContext context) {
    controller.pathRemoteStorage.listen(context, () {
      //o ruim que o signal(pathRemoteStorage) fica disponivel pra qualquer um
      Navigator.of(context).pop();
      Navigator.of(context).pop(controller.pathRemoteStorage.value);
    });

    final size = MediaQuery.of(context).size;

    final foto = ModalRoute.of(context)!.settings.arguments as XFile;

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
                Image.asset('assets/images/foto_confirm_icon.png'),
                const SizedBox(height: 24),
                const Text(
                  'CONFIRME SUA FOTO!',
                  style: ClinicasTheme.titleSmallStyle,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Verifique se a foto está legível e sem cortes. Caso contrário, clique em "TIRAR NOVA FOTO".',
                  style: ClinicasTheme.subtitleStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                //o file é do dart:io
                SizedBox(
                  width: size.width * 0.5,
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    strokeCap: StrokeCap.square,
                    strokeWidth: 4,
                    color: ClinicasTheme.orangeColor,
                    dashPattern: const [1, 10, 1, 4],
                    radius: const Radius.circular(16),
                    child: Image.file(
                      File(foto.path),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('TIRAR NOVA FOTO'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () async {
                            final imageBytes = await foto.readAsBytes();
                            final fileName = foto.name;

                            await controller.uploadFile(imageBytes, fileName);
                          },
                          child: const Text('SALVAR'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
