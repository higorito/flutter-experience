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
}
