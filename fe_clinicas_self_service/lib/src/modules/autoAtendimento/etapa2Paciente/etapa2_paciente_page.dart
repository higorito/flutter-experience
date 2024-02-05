import 'package:brasil_fields/brasil_fields.dart';
import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/etapa2Paciente/patient_controller.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/self_service_controller.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/widgets/clinica_self_service_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

class Etapa2PacientePage extends StatefulWidget {
  const Etapa2PacientePage({super.key});

  @override
  State<Etapa2PacientePage> createState() => _Etapa2PacientePageState();
}

class _Etapa2PacientePageState extends State<Etapa2PacientePage>
    with MessagesViewMixin {
  final formKey = GlobalKey<FormState>();
  final cpfEC = TextEditingController();
  final controller = Injector.get<PatientController>();

  @override
  void initState() {
    messageListener(controller);
    effect(() {
      final PatientController(:patiente, :patienteNotFound) = controller;

      if (patiente != null || patienteNotFound != null) {
        //selfservice vai setar e redirecionar
        Injector.get<SelfServiceController>()
            .goFormPatientAndNextStep(patiente);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: ClinicaSelfServiceAppbar(),
      body: LayoutBuilder(
        builder: (_, constrains) {
          return SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: constrains.maxHeight,
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background_login.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(36),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.94),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/logo_vertical.png',
                          width: size.width * 0.4,
                        ),
                        const SizedBox(
                          height: 46,
                        ),
                        TextFormField(
                          controller: cpfEC,
                          validator: Validatorless.required('CPF obrigatório'),
                          decoration: const InputDecoration(
                            labelText: 'Digite seu CPF',
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            // LengthLimitingTextInputFormatter(11),
                            CpfInputFormatter(),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Não sabe o CPF?',
                              style: TextStyle(
                                fontSize: 14,
                                color: ClinicasTheme.blueColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                controller.continueWithoutCpf();
                              },
                              child: const Text(
                                'Clique aqui',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: ClinicasTheme.orangeColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.width * .8,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                final formValid =
                                    formKey.currentState?.validate() ?? false;

                                if (formValid) {
                                  controller.getPatientByCpf(cpfEC.text);
                                }
                              },
                              child: const Text('PROSSEGUIR')),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
