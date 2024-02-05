import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_self_service/src/model/patiente_model.dart';

abstract interface class IPatientRepository {
  Future<Either<RepositoryEx, PatienteModel?>> getPatientByCpf(String cpf);
}
