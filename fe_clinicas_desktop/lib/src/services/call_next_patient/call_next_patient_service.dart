import 'dart:developer';

import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_desktop/src/repositories/attendant_desk/desk_assignment.dart';
import '../../models/patiente_information_form_model.dart';
import '../../repositories/painel/painel_repository.dart';
import '../../repositories/patiente_information_form/patient_information_form_repository.dart';

class CallNextPatientService {
  CallNextPatientService({
    required this.patientInformationFormRepository,
    required this.deskAssignmentRepository,
    required this.painelRepository,
  });

  final IPatientInformationFormRepository patientInformationFormRepository;
  final IDeskAssignmentRepository deskAssignmentRepository;
  final IPainelRepository painelRepository;

  Future<Either<RepositoryEx, PatienteInformationFormModel?>> execute() async {
    final result = await patientInformationFormRepository.callNextToCheckIn();

    switch (result) {
      case Left(value: final ex):
        return Left(ex);
      case Right(value: final form?): //nao nulo
        return updatePanel(form);
      case Right():
        return Right(null);
    }
  }

  Future<Either<RepositoryEx, PatienteInformationFormModel?>> updatePanel(
      PatienteInformationFormModel form) async {
    final resultDesk = await deskAssignmentRepository.getDeskAssignment();
    switch (resultDesk) {
      case Left(value: final ex):
        return Left(ex);
      case Right(value: final deskNumber):
        final resultPanel = await painelRepository.callOnPanel(
          form.password,
          deskNumber,
        );

        switch (resultPanel) {
          case Left(value: final ex):
            log('erro ao chamar paciente no painel!!',
                error: ex,
                stackTrace: StackTrace.fromString(
                    'Erro ao chamar paciente no painel!!!'));
            return Right(form);
          case Right():
            return Right(form);
        }
    }
  }
}
