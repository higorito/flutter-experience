import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_desktop/src/models/patiente_information_form_model.dart';
import 'package:fe_clinicas_desktop/src/repositories/patiente_information_form/patient_information_form_repository.dart';

class PatientInformationFormRepositoryImpl
    implements IPatientInformationFormRepository {
  PatientInformationFormRepositoryImpl({
    required this.restClient,
  });

  final RestClient restClient;

  @override
  Future<Either<RepositoryEx, PatienteInformationFormModel?>>
      callNextToCheckIn() async {
    final Response(:List data) =
        await restClient.auth.get('/patientInformationForm', queryParameters: {
      'status': PatienteInformationFormStatus.waiting.id,
      'page': 1,
      'limit': 1,
    });

    if (data.isEmpty) {
      return Right(null); //ai trata no controller pra mostrar mensagem
    }

    final formData = data.first;
    final updateStatusResult = await updateStatus(
      //aqui ele "reserva" o paciente para n ser chamado por outro
      formData['id'],
      PatienteInformationFormStatus.checkIn,
    );

    switch (updateStatusResult) {
      case Left(value: final ex):
        return Left(ex);
      case Right():
        formData['status'] = PatienteInformationFormStatus
            .checkIn.id; //aqui ele atualiza o status do paciente

        formData['patient'] = await _getPatientData(formData['patient_id']);
        //aqui ele pega os dados do paciente a partir do id dele
        return Right(PatienteInformationFormModel.fromJson(formData));
    }
  }

  Future<Map<String, dynamic>> _getPatientData(String id) async {
    final Response(:data) = await restClient.auth.get('/patients/$id');

    return data;
  }

  @override
  Future<Either<RepositoryEx, Unit>> updateStatus(
      String id, PatienteInformationFormStatus status) async {
    try {
      await restClient.auth.put(
        '/patientInformationForm/$id',
        data: {
          'status': status.id,
        },
      );
      return Right(unit);
    } on DioException catch (e, s) {
      log('Erro ao atualizar status do form ', error: e, stackTrace: s);
      return Left(RepositoryEx());
    }
  }
}
