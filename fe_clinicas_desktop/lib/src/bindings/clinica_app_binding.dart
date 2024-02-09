import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_desktop/src/core/env.dart';
import 'package:fe_clinicas_desktop/src/repositories/painel/painel_repository_impl.dart';
import 'package:fe_clinicas_desktop/src/repositories/patiente_information_form/patient_information_form_repository.dart';
import 'package:fe_clinicas_desktop/src/services/call_next_patient/call_next_patient_service.dart';
import 'package:flutter_getit/flutter_getit.dart';

import '../repositories/attendant_desk/desk_assignment.dart';
import '../repositories/attendant_desk/desk_assignment_impl.dart';
import '../repositories/painel/painel_repository.dart';
import '../repositories/patiente_information_form/patient_information_form_repository_impl.dart';

class ClinicaAppBinding extends ApplicationBindings {
  @override
  List<Bind<Object>> bindings() => [
        Bind.lazySingleton(
          (i) => RestClient(Env.backendBaseUrl),
        ),
        //todas binds de painel
        Bind.lazySingleton<IPatientInformationFormRepository>(
          (i) => PatientInformationFormRepositoryImpl(restClient: i()),
        ),
        Bind.lazySingleton<IDeskAssignmentRepository>(
          (i) => DeskAssignmentRepoImpl(restClient: i()),
        ),
        Bind.lazySingleton<IPainelRepository>(
          (i) => PainelRepositoryImpl(restClient: i()),
        ),
        //e o pai de todos
        Bind.lazySingleton(
          (i) => CallNextPatientService(
              patientInformationFormRepository: i(),
              deskAssignmentRepository: i(),
              painelRepository: i()),
        ),
      ];
}
