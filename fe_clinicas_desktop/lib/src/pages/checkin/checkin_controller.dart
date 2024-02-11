import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../models/patiente_information_form_model.dart';
import '../../repositories/patiente_information_form/patient_information_form_repository.dart';

class CheckinController with MessagesStateMixin {
  CheckinController({
    required IPatientInformationFormRepository patientInformationFormRepository,
  }) : _patientInformationFormRepository = patientInformationFormRepository;

  final informationForm = signal<PatienteInformationFormModel?>(null);

  final IPatientInformationFormRepository _patientInformationFormRepository;

  final endProcess = signal(false);

  Future<void> endChekin() async {
    if (informationForm() != null) {
      final result = await _patientInformationFormRepository.updateStatus(
          informationForm.value!.id,
          PatienteInformationFormStatus.beingAttended);

      switch (result) {
        case Left():
          showError('Erro ao finalizar checkin');
        case Right():
          endProcess.value = true;
      }
    } else {
      showError('Formulário não pode ser nulo!');
    }
  }
}
