import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_self_service/src/model/patiente_model.dart';
import 'package:fe_clinicas_self_service/src/model/self_service_model.dart';
import 'package:fe_clinicas_self_service/src/repositories/information_form/information_form_repository.dart';

class InformationFormRepositoryImpl implements IInformationFormRepository {
  final RestClient restClient;

  InformationFormRepositoryImpl({required this.restClient});

  @override
  Future<Either<RepositoryEx, Unit>> register(SelfServiceModel model) async {
    try {
      final SelfServiceModel(
        :nome!,
        :sobrenome!,
        patiente: PatienteModel(id: patienteId)!,
        documents: {
          DocumentType.carteirinha: List(first: carteirinhaDoc),
          DocumentType.pedidoMedico: List(first: pedidoMedicoDoc),
        }!
      ) = model;
      //isso aq da uma olhada
      await restClient.auth.post('/patientInformationForm', data: {
        'patient_id': patienteId,
        'health_insurance_card': carteirinhaDoc,
        'medical_order': pedidoMedicoDoc,
        'password': '$nome $sobrenome',
        'date_created': DateTime.now().toIso8601String(),
        'status': 'WAITING',
        'tests': [],
      });
      return Right(unit);
    } on DioException catch (e, s) {
      log('Erro ao registrar formulário de informações',
          error: e, stackTrace: s);
      return Left(RepositoryEx());
    }
  }
}
