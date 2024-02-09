import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_desktop/src/models/patiente_information_form_model.dart';

abstract interface class IPatientInformationFormRepository {
  Future<Either<RepositoryEx, PatienteInformationFormModel?>>
      callNextToCheckIn();

  Future<Either<RepositoryEx, Unit>> updateStatus(
      String id, PatienteInformationFormStatus status);
}
