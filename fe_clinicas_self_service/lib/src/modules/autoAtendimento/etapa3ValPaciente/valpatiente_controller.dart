import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_self_service/src/model/patiente_model.dart';
import 'package:fe_clinicas_self_service/src/repositories/patients/patient_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ValPatienteController with MessagesStateMixin {
  ValPatienteController({required IPatientRepository patientRepository})
      : _patientRepository = patientRepository;

  final IPatientRepository _patientRepository;

  PatienteModel? patiente;

  final _nextStep = signal<bool>(false);
  bool get nextStep => _nextStep();

  void goNextStep() {
    _nextStep.value = true;
  }

  Future<void> updateAndNext(PatienteModel model) async {
    final updateResult = await _patientRepository.update(model);

    switch (updateResult) {
      case Left():
        showError('Erro ao atualizar dados do paciente');
      case Right():
        showInfo('Dados do paciente atualizados com sucesso!');
        patiente = model;
        goNextStep();
    }
  }

  Future<void> registerAndNext(RegisterPatienteModel model) async {
    final registerResult = await _patientRepository.registrar(model);

    switch (registerResult) {
      case Left():
        showError('Erro ao cadastrar paciente');
      case Right(value: final patiente):
        showSuccess('Paciente cadastrado com sucesso!');
        this.patiente = patiente;
        goNextStep();
    }
  }
}
