import 'package:fe_clinicas_core/fe_clinicas_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with MessagesViewMixin {
  //pra mostrar mensagens de erro
  final formKey = GlobalKey<FormState>();

  final emailEC = TextEditingController();
  final senhaEC = TextEditingController();

  final controller = Injector.get<LoginController>();

  @override
  void initState() {
    messageListener(controller); //pra ficar ouvindo as mensagens
    effect(() {
      //fica ouvindo o signal
      if (controller.logado) {
        Navigator.of(context).pushReplacementNamed('/painel');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    emailEC.dispose();
    senhaEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
          minHeight: size.height,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_login.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(40),
            constraints: BoxConstraints(
              maxWidth: size.width * 0.55,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Text('LOGIN', style: ClinicasTheme.titleStyle),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      border: OutlineInputBorder(),
                    ),
                    controller: emailEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Campo obrigatório'),
                      Validatorless.email('E-mail inválido'),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Watch(
                    //pra ficar observando a mudança de estado do signal
                    (_) {
                      return TextFormField(
                        obscureText: controller.obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.showHidePassword();
                            },
                            icon: !controller.obscurePassword
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                        ),
                        controller: senhaEC,
                        validator: Validatorless.required('Campo obrigatório'),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                      width: size.width * 0.8,
                      height: 48,
                      child: ElevatedButton(
                          onPressed: () {
                            final valido =
                                formKey.currentState?.validate() ?? false;

                            if (valido) {
                              controller.login(emailEC.text, senhaEC.text);
                            }
                          },
                          child: const Text('Entrar'))),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
