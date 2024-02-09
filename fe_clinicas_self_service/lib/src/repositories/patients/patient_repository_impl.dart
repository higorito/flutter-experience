import 'dart:developer';
import 'package:dio/dio.dart';

import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_self_service/src/model/patiente_model.dart';
import 'package:fe_clinicas_self_service/src/repositories/patients/patient_repository.dart';

class PatienteRepositoryImpl implements IPatientRepository {
  final RestClient restClient;

  PatienteRepositoryImpl({required this.restClient});

  @override
  Future<Either<RepositoryEx, PatienteModel?>> getPatientByCpf(
      String cpf) async {
    try {
      final Response(:List data) = await restClient.auth
          .get('/patients', queryParameters: {'document': cpf});

      if (data.isEmpty) {
        return Right(null);
      }

      return Right(PatienteModel.fromJson(
          data.first)); //pq é uma lista, comverteu ali na response(:List data)
    } on DioException catch (e, s) {
      log('Erro ao buscar paciente por cpf: $cpf', error: e, stackTrace: s);
      return Left(RepositoryEx());
    }
  }

  @override
  Future<Either<RepositoryEx, Unit>> update(PatienteModel patient) async {
    try {
      await restClient.auth
          .put('/patients/${patient.id}', data: patient.toJson());
      return Right(unit);
    } on DioException catch (e, s) {
      log('Erro ao atualizar paciente: ${patient.id}', error: e, stackTrace: s);
      return Left(RepositoryEx());
    }
  }

  @override
  Future<Either<RepositoryEx, PatienteModel>> registrar(
      RegisterPatienteModel patient) async {
    try {
      final Response(:data) = await restClient.auth.post('/patients', data: {
        'name': patient.name,
        'email': patient.email,
        'phone_number': patient.phoneNumber,
        'document': patient.document,
        'address': {
          'cep': patient.address.cep,
          'street_address': patient.address.streetAddress,
          'number': patient.address.number,
          'address_complement': patient.address.addressComplement,
          'state': patient.address.state,
          'city': patient.address.city,
          'district': patient.address.district,
        },
        'guardian': patient.guardian,
        'guardian_identification_number': patient.guardianIdentificationNumber
      });
      return Right(PatienteModel.fromJson(data));
    } on DioException catch (e, s) {
      log('Erro ao cadastrar paciente', error: e, stackTrace: s);
      return Left(RepositoryEx());
    }
  }
}
