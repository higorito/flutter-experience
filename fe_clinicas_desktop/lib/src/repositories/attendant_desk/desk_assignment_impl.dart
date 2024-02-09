import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fe_clinicas_core/fe_clinicas_core.dart';

import 'package:fe_clinicas_desktop/src/repositories/attendant_desk/desk_assignment.dart';

class DeskAssignmentRepoImpl implements IDeskAssignmentRepository {
  final RestClient restClient;

  DeskAssignmentRepoImpl({required this.restClient});

  @override
  Future<Either<RepositoryEx, Unit>> startService(int deskNumber) async {
    final result = await _clearDeskByUser();

    switch (result) {
      case Left(value: final exception):
        return Left(exception);
      case Right():
        await restClient.auth.post('/attendantDeskAssignment', data: {
          'user_id': '#userAuthRef',
          'desk_number': deskNumber,
          'date_created': DateTime.now().toIso8601String(),
          'status': 'Available'
        });
        return Right(unit);
    }
  }

  Future<Either<RepositoryEx, Unit>> _clearDeskByUser() async {
    try {
      final desk = await _getDeskByUser();

      if (desk != null) {
        await restClient.auth.delete('/attendantDeskAssignment/${desk.id}');
      }

      return Right(unit);
    } on DioException catch (e, s) {
      log('Erro ao delear numero do guiche', error: e, stackTrace: s);
      return Left(RepositoryEx());
    }
  }

  //precisa buscar e deletar caso o deskNumber já esteja em uso
  Future<({String id, int deskNumber})?> _getDeskByUser() async {
    final Response(:List data) = await restClient.auth.get(
        '/attendantDeskAssignment',
        queryParameters: {'user_id': '#userAuthRef'});
    //userAuthRef é um coringa do JWT
    if (data
        case List(
          isNotEmpty: true,
          first: {'id': String id, 'desk_number': int deskNumberDes}
        )) {
      return (
        id: id,
        deskNumber: deskNumberDes,
      );
    }
    return null;
  }

  @override
  Future<Either<RepositoryEx, int>> getDeskAssignment() async {
    try {
      final Response(data: List(first: data)) = await restClient.auth.get(
        '/attendantDeskAssignment',
        queryParameters: {'user_id': '#userAuthRef'},
      );
      return Right(data['desk_number']);
      //o numero da mesa
    } on DioException catch (e, s) {
      log('Erro ao buscar numero do guiche', error: e, stackTrace: s);
      return Left(RepositoryEx());
    }
  }
}
