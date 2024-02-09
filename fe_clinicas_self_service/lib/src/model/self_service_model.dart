import 'package:flutter/material.dart';

import 'package:fe_clinicas_self_service/src/model/patiente_model.dart';

enum DocumentType {
  carteirinha,
  pedidoMedico,
}

final class SelfServiceModel {
  SelfServiceModel({
    this.nome,
    this.sobrenome,
    this.patiente,
    this.documents,
  });

  final String? nome;
  final String? sobrenome;

  final PatienteModel? patiente;

  //map pq é o tipo e o caminho do arquivo
  final Map<DocumentType, List<String>>? documents;

  SelfServiceModel clear() {
    return copyWith(
      nome: () => '',
      sobrenome: () => '',
      patiente: () => null,
      documents: () => null,
    );
  }

  SelfServiceModel copyWith({
    ValueGetter<String?>? nome,
    ValueGetter<String?>? sobrenome,
    ValueGetter<PatienteModel?>? patiente,
    ValueGetter<Map<DocumentType, List<String>>?>? documents,
  }) {
    return SelfServiceModel(
      nome: nome != null ? nome() : this.nome,
      sobrenome: sobrenome != null ? sobrenome() : this.sobrenome,
      patiente: patiente != null ? patiente() : this.patiente,
      documents: documents != null ? documents() : this.documents,
    );
  }
}
