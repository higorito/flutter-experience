import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_self_service/src/model/patiente_model.dart';
import 'package:fe_clinicas_self_service/src/repositories/patients/patient_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PatientController with MessagesStateMixin {
  final IPatientRepository _patientRepository;

  PatientController({required IPatientRepository patientRepository})
      : _patientRepository = patientRepository;

  //variaveis de estado
  final _patienteNotFound = ValueSignal<bool?>(null);
  bool? get patienteNotFound => _patienteNotFound();

  final _patiente = ValueSignal<PatienteModel?>(null);
  PatienteModel? get patiente => _patiente();

  Future<void> getPatientByCpf(String cpf) async {
    final result = await _patientRepository.getPatientByCpf(cpf);

    bool patienteNotFound = false;
    PatienteModel? patiente;

    switch (result) {
      case Right(value: PatienteModel model?): //se nao for nulo
        patienteNotFound = false;
        patiente = model;
      case Right(value: _): //se for qlq outra coisa
        patienteNotFound = true;
        patiente = null;
      case Left():
        showError('Erro ao buscar paciente');
        return;
    }

    //notificando, como é 2 variaveis vai notificar 2x entao faz um grupo
    batch(() {
      _patiente.forceUpdate(patiente);
      _patienteNotFound.forceUpdate(patienteNotFound);
    });
  }

  void continueWithoutCpf() {
    batch(() {
      _patiente.value = patiente; //por causa do bug do signals
      _patienteNotFound.forceUpdate(true);
    });
  }
}
