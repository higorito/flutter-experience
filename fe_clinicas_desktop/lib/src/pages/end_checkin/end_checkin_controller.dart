import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_desktop/src/models/patiente_information_form_model.dart';
import 'package:fe_clinicas_desktop/src/services/call_next_patient/call_next_patient_service.dart';
import 'package:signals_flutter/signals_flutter.dart';

class EndCheckinController with MessagesStateMixin {
  EndCheckinController({
    required CallNextPatientService callNextPatientService,
  }) : _callNextPatientService = callNextPatientService;

  final CallNextPatientService _callNextPatientService;

  final informationForm = signal<PatienteInformationFormModel?>(null);

  Future<void> callNextPatient() async {
    final result = await _callNextPatientService.execute();

    switch (result) {
      case Left():
        showError('Erro ao chamar próxima senha');
      case Right(value: final form?):
        informationForm.value = form;
      case _:
        showInfo('Nenhuma senha disponível para chamar');
    }
  }
}
