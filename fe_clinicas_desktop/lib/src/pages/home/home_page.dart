import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_desktop/src/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with MessagesViewMixin {
  final formKey = GlobalKey<FormState>();
  final guicheEC = TextEditingController();

  final controller = Injector.get<HomeController>();

  @override
  void initState() {
    messageListener(controller);
    effect(() {
      if (controller.informationForm != null) {
        //provavelmente o erro ta antes de informationForm
        Navigator.of(context).pushReplacementNamed(
          '/pre-checkin',
          arguments: controller.informationForm,
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    guicheEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: ClinicasAppbar(),
      body: Center(
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(34),
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
                const Text(
                  'Bem vindo!',
                  style: ClinicasTheme.titleStyle,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Preencha o campo com o número de Guichê',
                  style: ClinicasTheme.subtitleSmallStyle,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: guicheEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('Campo obrigatório'),
                    Validatorless.number('Apenas números'),
                  ]),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Número do Guichê',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 36),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final isValid = formKey.currentState?.validate() ?? false;
                      if (isValid) {
                        controller.startService(int.parse(guicheEC.text));
                      }
                    },
                    child: const Text('CHAMAR PRÓXIMO PACIENTE'),
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
