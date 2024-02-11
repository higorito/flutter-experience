import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fe_clinicas_core/fe_clinicas_core.dart';

import 'user_repository.dart';

class UserRepositoryImpl implements IUserRepository {
  //acesso ao back

  UserRepositoryImpl({required this.restClient});
  final RestClient restClient;

  @override
  Future<Either<AuthEx, String>> login(String email, String password) async {
    try {
      //extraiu a resposta do json com o data, criou um mapa e a chave 'access_token' foi jogada para a variável access_token mesma ideia de destructuring
      final Response(data: {'access_token': access_token}) =
          await restClient.unAuth.post(
        '/auth',
        data: {
          'email': email,
          'password': password,
          // 'adm': true, /outra area do sistema
        },
      );
      return Right(access_token);
    } on DioException catch (e, s) {
      log('Erro ao fazer login', error: e, stackTrace: s);
      return switch (e) {
        DioException(response: Response(statusCode: HttpStatus.forbidden)?) =>
          Left(AuthUnauthorizedEx()),
        _ => Left(AuthErrorEx(message: 'Erro ao fazer login!'))
      };
    }
  }
}
