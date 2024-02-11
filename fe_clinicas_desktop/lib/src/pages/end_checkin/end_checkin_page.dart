import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'end_checkin_controller.dart';

class EndCheckinPage extends StatefulWidget {
  const EndCheckinPage({super.key});

  @override
  State<EndCheckinPage> createState() => _EndCheckinPageState();
}

class _EndCheckinPageState extends State<EndCheckinPage>
    with MessagesViewMixin {
  final controller = Injector.get<EndCheckinController>();

  @override
  void initState() {
    messageListener(controller);

    effect(() {
      if (controller.informationForm() != null) {
        Navigator.of(context).pushReplacementNamed('/pre-checkin',
            arguments: controller.informationForm());
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: ClinicasAppbar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.only(top: size.height * 0.1),
          padding: const EdgeInsets.all(40),
          constraints: BoxConstraints(
            maxWidth: size.width * 0.45,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ClinicasTheme.orangeColor),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/check_icon.png'),
              const SizedBox(height: 30),
              const Text(
                'Atendimento finalizado com sucesso!',
                style: ClinicasTheme.titleSmallStyle,
              ),
              const SizedBox(height: 50),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.callNextPatient();
                  },
                  child: const Text('CHAMAR OUTRA SENHA'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
