import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/self_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class Etapa1NomesPage extends StatefulWidget {
  const Etapa1NomesPage({super.key});

  @override
  State<Etapa1NomesPage> createState() => _Etapa1NomesPageState();
}

class _Etapa1NomesPageState extends State<Etapa1NomesPage> {
  final formKey = GlobalKey<FormState>();
  final nomeEC = TextEditingController();
  final sobrenomeEC = TextEditingController();

  //pegar o controller, ele é externo. pq ele n pode morrer aqui.vai controlar as telas
  final selfServiceController = Injector.get<SelfServiceController>();

  @override
  void dispose() {
    nomeEC.dispose();
    sobrenomeEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        nomeEC.text = '';
        sobrenomeEC.text = '';
        selfServiceController.clearForm();
      },
      child: Scaffold(
        appBar: ClinicasAppbar(
          actions: [
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: 1,
                    child: Text('Finalizar Terminal'),
                  ),
                ];
              },
              child: const IconPopupMenu(),
              onSelected: (value) async {
                if (value == 1) {
                  final nav = Navigator.of(context);
                  await SharedPreferences.getInstance()
                      .then((sp) => sp.clear());
                  nav.pushNamedAndRemoveUntil('/', (route) => false);
                }
              },
            )
          ],
        ),
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
                          const Text(
                            'Bem Vindo!',
                            style: ClinicasTheme.titleStyle,
                          ),
                          const SizedBox(
                            height: 46,
                          ),
                          TextFormField(
                            controller: nomeEC,
                            validator:
                                Validatorless.required('Digite seu nome'),
                            decoration: const InputDecoration(
                              labelText: 'Digite seu nome',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: sobrenomeEC,
                            validator:
                                Validatorless.required('Digite o sobrenome'),
                            decoration: const InputDecoration(
                              labelText: 'Digite o sobrenome',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: size.width * .8,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                  final formValid =
                                      formKey.currentState?.validate() ?? false;

                                  if (formValid) {
                                    selfServiceController
                                        .setNomesDataAndNextStep(
                                            nomeEC.text, sobrenomeEC.text);
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
      ),
    );
  }
}
