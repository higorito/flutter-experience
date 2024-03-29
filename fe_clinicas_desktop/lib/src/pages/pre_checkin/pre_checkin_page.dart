import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_desktop/src/models/patiente_information_form_model.dart';
import 'package:fe_clinicas_desktop/src/pages/pre_checkin/pre_chekin_controller.dart';
import 'package:fe_clinicas_desktop/src/shared/data_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PreCheckinPage extends StatefulWidget {
  const PreCheckinPage({super.key});

  @override
  State<PreCheckinPage> createState() => _PreCheckinPageState();
}

class _PreCheckinPageState extends State<PreCheckinPage>
    with MessagesViewMixin {
  final controller = Injector.get<PreChekinController>();

  @override
  void initState() {
    messageListener(controller);
    //ai nessa tela n vai ter efeito, vai buildar assim que o signal mudar
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final PatienteInformationFormModel(:password, :patient) =
        controller.informationForm.watch(context)!;
    //inves de usar o signal.value, usa o watch pq ai ja vai atualizar a tela, fica escutando

    return Scaffold(
      appBar: ClinicasAppbar(),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: size.width * 0.5,
            margin: const EdgeInsets.only(top: 45),
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ClinicasTheme.orangeColor),
            ),
            child: Column(
              children: [
                Image.asset('assets/images/patient_avatar.png'),
                const SizedBox(height: 20),
                const Text(
                  'A Senha foi',
                  style: ClinicasTheme.titleSmallStyle,
                ),
                const SizedBox(
                  height: 18,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 22),
                  width: size.width * 0.12,
                  decoration: BoxDecoration(
                    color: ClinicasTheme.orangeColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    password,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 46),
                DataItem(
                  label: 'Nome do Paciente',
                  value: patient.name,
                  padding: const EdgeInsets.only(bottom: 15),
                ),
                DataItem(
                  label: 'E-mail',
                  value: patient.email,
                  padding: const EdgeInsets.only(bottom: 15),
                ),
                DataItem(
                  label: 'Telefone',
                  value: patient.phoneNumber,
                  padding: const EdgeInsets.only(bottom: 15),
                ),
                DataItem(
                  label: 'CPF',
                  value: patient.document,
                  padding: const EdgeInsets.only(bottom: 15),
                ),
                DataItem(
                  label: 'CEP',
                  value: patient.address.cep,
                  padding: const EdgeInsets.only(bottom: 15),
                ),
                DataItem(
                  label: 'Endereço',
                  value:
                      '${patient.address.streetAddress}, ${patient.address.number},${patient.address.addressComplement}, ${patient.address.city} - ${patient.address.state}, ${patient.address.district}',
                  padding: const EdgeInsets.only(bottom: 15),
                ),
                DataItem(
                  label: 'Responsável',
                  value: patient.guardian,
                  padding: const EdgeInsets.only(bottom: 15),
                ),
                DataItem(
                  label: 'Documento de Identificação',
                  value: patient.guardianIdentificationNumber,
                  padding: const EdgeInsets.only(bottom: 15),
                ),
                const SizedBox(
                  height: 46,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            fixedSize: const Size.fromHeight(48)),
                        onPressed: () {
                          controller.next();
                          //TEM UM ERRO AQUI, chama o proximo, mas ai o outro n chama
                        },
                        child: const Text('CHAMAR PRÓXIMO'),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size.fromHeight(48)),
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/checkin',
                              arguments: controller.informationForm.value);
                        },
                        child: const Text('ATENDER'),
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
