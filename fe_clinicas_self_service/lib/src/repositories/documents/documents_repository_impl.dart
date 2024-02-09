import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fe_clinicas_core/fe_clinicas_core.dart';

import 'package:fe_clinicas_self_service/src/repositories/documents/documents_repository.dart';

class DocumentsRepositoryImpl implements IDocumentsRepository {
  final RestClient restClient;

  DocumentsRepositoryImpl({required this.restClient});

  @override
  Future<Either<RepositoryEx, String>> uploadFile(
      Uint8List file, String fileName) async {
    //basicamente são jsons q vao ficar sendo enviados e recebidos
    //são tudo string
    //formdata é melhor q byte64
    final formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(file, filename: fileName),
    });

    try {
      final Response(data: {'url': pathImage}) =
          await restClient.auth.post('/uploads', data: formData);
      //aq o DIO ja entendeu tudo, que é um json do tipo formdata e que é um post com o multipart

      return Right(pathImage);
    } on DioException catch (e, s) {
      log('erro ao fazer upload do arquivo', error: e, stackTrace: s);
      return Left(RepositoryEx());
    }
  }
}
