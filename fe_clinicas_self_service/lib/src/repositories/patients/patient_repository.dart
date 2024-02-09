import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_self_service/src/model/patiente_model.dart';

//record é um tipo agregador e imutável

typedef RegisterPatienteAddressModel = ({
  String cep,
  String streetAddress,
  String number,
  String addressComplement,
  String state,
  String city,
  String district,
});

typedef RegisterPatienteModel = ({
  String name,
  String email,
  String phoneNumber,
  String document,
  RegisterPatienteAddressModel address,
  String guardian,
  String guardianIdentificationNumber
});

abstract interface class IPatientRepository {
  Future<Either<RepositoryEx, PatienteModel?>> getPatientByCpf(String cpf);

  Future<Either<RepositoryEx, Unit>> update(PatienteModel patient);

  Future<Either<RepositoryEx, PatienteModel>> registrar(
      RegisterPatienteModel patient);
}
