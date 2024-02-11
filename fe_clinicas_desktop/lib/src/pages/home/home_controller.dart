import 'package:asyncstate/asyncstate.dart' as asyncstate;
import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_desktop/src/services/call_next_patient/call_next_patient_service.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../models/patiente_information_form_model.dart';
import '../../repositories/attendant_desk/desk_assignment.dart';

class HomeController with MessagesStateMixin {
  final IDeskAssignmentRepository _deskAssignmentRepository;
  final CallNextPatientService _callNextPatientService;

  //aq vai ser so pra avisar a tela
  final _informationForm = signal<PatienteInformationFormModel?>(null);
  PatienteInformationFormModel? get informationForm => _informationForm();

  HomeController({
    required IDeskAssignmentRepository deskAssignmentRepository,
    required CallNextPatientService callNextPatientService,
  })  : _deskAssignmentRepository = deskAssignmentRepository,
        _callNextPatientService = callNextPatientService;

  Future<void> startService(int deskNumber) async {
    asyncstate.AsyncState.show();
    final result = await _deskAssignmentRepository.startService(deskNumber);

    switch (result) {
      case Left():
        asyncstate.AsyncState.hide();
        showError('Erro ao iniciar guichê');
      case Right(value: _):
        final resultNextPatient = await _callNextPatientService.execute();

        switch (resultNextPatient) {
          case Left():
            showError('Erro ao chamar próximo paciente');
          case Right(value: final form?):
            asyncstate.AsyncState.hide();
            _informationForm.value = form;
          case Right(value: _):
            asyncstate.AsyncState.hide();
            showInfo('Não há pacientes na fila para serem chamados');
        }
    }
  }
}
