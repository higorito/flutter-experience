import 'package:fe_clinicas_self_service/src/model/patiente_model.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/etapa3ValPaciente/etapa3_val_paciente_page.dart';
import 'package:flutter/material.dart';

mixin PatienteFormController on State<Etapa3ValPacientePage> {
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final phoneEC = TextEditingController();
  final documentEC = TextEditingController();
  final cepEC = TextEditingController();
  final streetEC = TextEditingController();
  final numberEC = TextEditingController();
  final complementEC = TextEditingController();
  final stateEC = TextEditingController();
  final cityEC = TextEditingController();
  final districtEC = TextEditingController();
  final guardianEC = TextEditingController();
  final guardianIdentificationNumberEC = TextEditingController();

  void disposeForm() {
    nameEC.dispose();
    emailEC.dispose();
    phoneEC.dispose();
    documentEC.dispose();
    cepEC.dispose();
    streetEC.dispose();
    numberEC.dispose();
    complementEC.dispose();
    stateEC.dispose();
    cityEC.dispose();
    districtEC.dispose();
    guardianEC.dispose();
    guardianIdentificationNumberEC.dispose();
  }

  void initializeForm(final PatienteModel? model) {
    if (model != null) {
      nameEC.text = model.name;
      emailEC.text = model.email;
      phoneEC.text = model.phoneNumber;
      documentEC.text = model.document;
      cepEC.text = model.address.cep;
      streetEC.text = model.address.streetAddress;
      numberEC.text = model.address.number;
      complementEC.text = model.address.complement;
      stateEC.text = model.address.state;
      cityEC.text = model.address.city;
      districtEC.text = model.address.district;
      guardianEC.text = model.guardian;
      guardianIdentificationNumberEC.text = model.guardianIdentificationNumber;
    }
  }
}
