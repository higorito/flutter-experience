import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/self_service_controller.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/widgets/clinica_self_service_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class DonePage extends StatelessWidget {
  DonePage({super.key});

  final selfServiceController = Injector.get<SelfServiceController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 100),
            padding: const EdgeInsets.all(32),
            width: size.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ClinicasTheme.orangeColor),
            ),
            child: Column(
              children: [
                Image.asset('assets/images/stroke_check.png'),
                const SizedBox(height: 24),
                const Text(
                  'SUA SENHA É',
                  style: ClinicasTheme.titleSmallStyle,
                ),
                const SizedBox(height: 18),
                Container(
                  constraints: BoxConstraints(
                    //o minimo
                    minWidth: size.width * 0.3,
                    minHeight: size.width * 0.08,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                  decoration: BoxDecoration(
                    color: ClinicasTheme.orangeColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    selfServiceController.password,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'AGUARDE! \n',
                        style: ClinicasTheme.titleSmallStyle,
                      ),
                      TextSpan(
                        text: 'Acompanhe a chamada no ',
                        style: ClinicasTheme.subtitleStyle,
                        children: [
                          TextSpan(
                            text: 'painel.',
                            style: TextStyle(
                              color: ClinicasTheme.orangeColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Imprimir senha'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: SizedBox(
                        height: 56,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text('Enviar por e-mail'),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 26),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ClinicasTheme.orangeColor,
                    fixedSize: Size(size.width * 0.85, 60),
                  ),
                  onPressed: () {
                    selfServiceController.restartProcess();
                  },
                  child: const Text(
                    'FINALIZAR',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
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
