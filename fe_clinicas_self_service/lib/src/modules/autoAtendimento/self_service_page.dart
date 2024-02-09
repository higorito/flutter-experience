import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/self_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';

class SelfServicePage extends StatefulWidget {
  const SelfServicePage({super.key});

  @override
  State<SelfServicePage> createState() => _SelfServicePageState();
}

class _SelfServicePageState extends State<SelfServicePage>
    with MessagesViewMixin {
  final controller = Injector.get<SelfServiceController>();

  @override
  void initState() {
    messageListener(controller);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.startProcess();
      effect(() {
        final step = controller.step;
        var baseRoute = '/self-service/';
        //quando troca o none pra qlq um ele vai acionar esse efeito aqui e vai fazer o pushNamed
        //serve pra redirecionar para a pagina correta, controla o fluxo
        switch (step) {
          case FormSteps.none:
            return;
          case FormSteps.nomes:
            baseRoute += 'etapa1NomesPage';
          case FormSteps.paciente:
            baseRoute += 'Etapa2PacientePage';
          case FormSteps.valpaciente:
            baseRoute += 'etapa3ValPacientePage';
          case FormSteps.documentos:
            baseRoute += 'etapa4DocumentosPage';
          case FormSteps.done:
            // Navigator.of(context).pushNamedAndRemoveUntil(
            //   '/self-service/done',
            //   ModalRoute.withName('/self-service'),
            //   arguments: controller.password,
            // );
            baseRoute += 'donePage';
          case FormSteps.restart:
            Navigator.of(context)
                .popUntil(ModalRoute.withName('/self-service')); //limpa a pilha
            controller.startProcess();
            return;
        }

        Navigator.of(context).pushNamed(baseRoute);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
