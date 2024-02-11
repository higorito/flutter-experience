import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_desktop/src/pages/checkin/checkin_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../models/patiente_information_form_model.dart';
import '../../shared/data_item.dart';
import 'widgets/checkin_image_link.dart';

class CheckinPage extends StatefulWidget {
  const CheckinPage({super.key});

  @override
  State<CheckinPage> createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> with MessagesViewMixin {
  final controller = Injector.get<CheckinController>();

  @override
  void initState() {
    messageListener(controller);
    effect(() {
      if (controller.endProcess()) {
        Navigator.of(context).pushReplacementNamed('/end-checkin');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final PatienteInformationFormModel(
      :password,
      :patient,
      :medicalOrder,
      :healthInsuranceCard
    ) = controller.informationForm.watch(context)!;

    return Scaffold(
      appBar: ClinicasAppbar(),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.5,
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
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ClinicasTheme.lightOrange,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Cadastro ',
                    style: ClinicasTheme.subtitleSmallStyle.copyWith(
                      color: ClinicasTheme.orangeColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
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
                  height: 22,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ClinicasTheme.lightOrange,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Validar Carteitinha e Pedidos Médicos',
                    style: ClinicasTheme.subtitleSmallStyle.copyWith(
                      color: ClinicasTheme.orangeColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CheckinImageLink(
                      label: 'Carteirinha',
                      image: healthInsuranceCard,
                    ),
                    Column(
                      children: [
                        CheckinImageLink(
                          label: 'Pedido Médico',
                          image: medicalOrder,
                        ),
                        //se eu tivesse uma lista de pedidos médicos poderia ser feito assim:
                        // for(final(index, medicalOrder) in medicalOrder.indexed ) //esse indexed é de lista
                        //   CheckinImageLink(
                        //     label: 'Pedido Médico ${index + 1}',
                        //     image: medicalOrder,
                        //   ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.endChekin();
                    },
                    child: const Text('FINALIZAR ATENDIMENTO'),
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
