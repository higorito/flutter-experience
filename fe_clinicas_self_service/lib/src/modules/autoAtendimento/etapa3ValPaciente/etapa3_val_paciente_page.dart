import 'package:brasil_fields/brasil_fields.dart';
import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_self_service/src/model/self_service_model.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/etapa3ValPaciente/val_patiente_form_controller.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/etapa3ValPaciente/valpatiente_controller.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/self_service_controller.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/widgets/clinica_self_service_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

class Etapa3ValPacientePage extends StatefulWidget {
  const Etapa3ValPacientePage({super.key});

  @override
  State<Etapa3ValPacientePage> createState() => _Etapa3ValPacientePageState();
}

class _Etapa3ValPacientePageState extends State<Etapa3ValPacientePage>
    with PatienteFormController, MessagesViewMixin {
  //puxou o mixin PatienteFormController com os textEditingController

  final formKey = GlobalKey<FormState>();

  final selfServiceController = Injector.get<SelfServiceController>();

  late bool patienteFound;
  late bool enableForm;

  final ValPatienteController controller =
      Injector.get<ValPatienteController>();

  @override
  void initState() {
    messageListener(controller);

    final SelfServiceModel(:patiente) =
        selfServiceController.model; //serve para pegar o paciente

    patienteFound = patiente != null;

    //se o paciente for encontrado, o form não pode ser editado
    enableForm = !patienteFound;
    initializeForm(patiente);

    effect(() {
      if (controller.nextStep) {
        selfServiceController.updatePatienteAndGoDocument(controller.patiente);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    disposeForm();
    super.dispose();
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
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Visibility(
                    visible: patienteFound,
                    replacement: Image.asset('assets/images/lupa_icon.png'),
                    child: Image.asset('assets/images/check_icon.png'),
                  ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: patienteFound,
                    replacement: const Text(
                      'Cadastro não encontrado!',
                      style: ClinicasTheme.titleSmallStyle,
                      textAlign: TextAlign.center,
                    ),
                    child: const Text(
                      'Cadastro Encontrado!',
                      style: ClinicasTheme.titleSmallStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: patienteFound,
                    replacement: const Text(
                      'Preencha os campos abaixo para continuar',
                      style: ClinicasTheme.subtitleStyle,
                      textAlign: TextAlign.center,
                    ),
                    child: const Text(
                      'Confirme os dados cadastrados',
                      style: ClinicasTheme.subtitleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 22),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: nameEC,
                    validator: Validatorless.required('Nome do Paciente'),
                    decoration: const InputDecoration(
                      labelText: 'Nome do Paciente',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: emailEC,
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Email obrigatório'),
                        Validatorless.email('Email inválido'),
                      ],
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: phoneEC,
                    validator: Validatorless.required('Telefone obrigatório'),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter()
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Telefone',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: documentEC,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter()
                    ],
                    validator: Validatorless.required('CPF obrigatório'),
                    decoration: const InputDecoration(
                      labelText: 'Digite o CPF',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: cepEC,
                    validator: Validatorless.required('CEP obrigatório'),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CepInputFormatter()
                    ],
                    decoration: const InputDecoration(
                      labelText: 'CEP',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: streetEC,
                          validator:
                              Validatorless.required('Endereço obrigatório'),
                          decoration: const InputDecoration(
                            labelText: 'Endereço',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Flexible(
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: numberEC,
                          validator:
                              Validatorless.required('Número obrigatório'),
                          decoration: const InputDecoration(
                            labelText: 'Nº',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: complementEC,
                          decoration: const InputDecoration(
                            labelText: 'Complemento',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Flexible(
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: stateEC,
                          validator: Validatorless.required('UF obrigatório'),
                          decoration: const InputDecoration(
                            labelText: 'UF',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: cityEC,
                          validator:
                              Validatorless.required('Cidade obrigatório'),
                          decoration: const InputDecoration(
                            labelText: 'Cidade',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Flexible(
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: districtEC,
                          validator:
                              Validatorless.required('Bairro obrigatório'),
                          decoration: const InputDecoration(
                            labelText: 'Bairro',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: guardianEC,
                    decoration: const InputDecoration(
                      labelText: 'Responsável Legal',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: guardianIdentificationNumberEC,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter()
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Identidade do Responsável',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Visibility(
                    visible: !enableForm,
                    replacement: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          final formValid =
                              formKey.currentState?.validate() ?? false;
                          if (formValid) {
                            if (patienteFound) {
                              controller.updateAndNext(
                                updatePatiente(
                                    selfServiceController.model.patiente!),
                              );
                            } else {
                              controller
                                  .registerAndNext(createPatienteRegister());
                            }
                          }
                        },
                        child: Visibility(
                          visible: !patienteFound,
                          replacement:
                              const Text('SALVAR ALTERAÇÕES E CONTINUAR'),
                          child: const Text('CADASTRAR'),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    enableForm = true;
                                  });
                                },
                                child: const Text('EDITAR')),
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: ElevatedButton(
                                onPressed: () {
                                  final formValid =
                                      formKey.currentState?.validate() ?? false;
                                  if (formValid) {
                                    controller.patiente =
                                        selfServiceController.model.patiente;
                                    controller.goNextStep();
                                  }
                                },
                                child: const Text('CONTINUAR')),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
