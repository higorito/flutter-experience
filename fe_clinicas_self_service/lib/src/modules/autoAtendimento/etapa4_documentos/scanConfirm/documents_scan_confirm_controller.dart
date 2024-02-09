import 'dart:typed_data';

import 'package:asyncstate/asyncstate.dart';
import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_self_service/src/repositories/documents/documents_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class DocumentsScanConfirmController with MessagesStateMixin {
  DocumentsScanConfirmController({required this.documentsRepository});

  final IDocumentsRepository documentsRepository;

  //vai atualizar conforme o path do arquivo
  //upload e download do arquivo no bd
  final pathRemoteStorage = signal<String?>(null);

  Future<void> uploadFile(Uint8List imageBytes, String fileName) async {
    final result = await documentsRepository
        .uploadFile(imageBytes, fileName)
        .asyncLoader();

    switch (result) {
      case Left():
        showError('Erro ao fazer upload do arquivo');
      case Right(value: final pathImage):
        pathRemoteStorage.value = pathImage;
    }
  }
}
