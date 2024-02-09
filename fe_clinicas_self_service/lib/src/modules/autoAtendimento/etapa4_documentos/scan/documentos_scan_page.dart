import 'package:asyncstate/asyncstate.dart';
import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/widgets/clinica_self_service_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class DocumentosScanPage extends StatefulWidget {
  const DocumentosScanPage({super.key});

  @override
  State<DocumentosScanPage> createState() => _DocumentosScanPageState();
}

class _DocumentosScanPageState extends State<DocumentosScanPage> {
  late CameraController cameraController;

  @override
  void initState() {
    cameraController = CameraController(
        Injector.get<List<CameraDescription>>().first, ResolutionPreset.max);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                Image.asset('assets/images/cam_icon.png'),
                const SizedBox(height: 24),
                const Text(
                  'TIRAR FOTO!',
                  style: ClinicasTheme.titleSmallStyle,
                ),
                const SizedBox(height: 28),
                const Text(
                  'segure o documento na frente da câmera e clique no botão para tirar a foto.',
                  style: ClinicasTheme.subtitleStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                //vai demorar um pouco para inicializar a camera
                //e tambem pode usar estados que ja vem do future
                FutureBuilder(
                  future: cameraController.initialize(),
                  builder: (context, snapshot) {
                    switch (snapshot) {
                      case AsyncSnapshot(
                          connectionState:
                              ConnectionState.waiting || ConnectionState.active
                        ):
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      case AsyncSnapshot(
                          connectionState: ConnectionState.done,
                        ):
                        if (cameraController.value.isInitialized) {
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: SizedBox(
                                width: size.width * 0.48,
                                child: CameraPreview(
                                  cameraController,
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    strokeCap: StrokeCap.square,
                                    strokeWidth: 4,
                                    color: ClinicasTheme.orangeColor,
                                    dashPattern: [1, 10, 1, 4],
                                    radius: const Radius.circular(16),
                                    child: const SizedBox.expand(),
                                  ),
                                ),
                              ));
                        }
                    }
                    return const Text('Erro ao inicializar a camera');
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: size.width * 0.80,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      final foto = await cameraController
                          .takePicture()
                          .asyncLoader(); //tirar foto

                      final nav = Navigator.of(context);

                      nav.pushNamed(
                          '/self-service/etapa4DocumentosPage/scan/confirm',
                          arguments: foto);
                      //enviando a foto para a proxima tela
                    },
                    child: const Text('TIRAR FOTO'),
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
