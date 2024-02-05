import 'package:flutter/material.dart';

import 'package:fe_clinicas_self_service/src/model/patiente_model.dart';

final class SelfServiceModel {
  SelfServiceModel({
    this.nome,
    this.sobrenome,
    this.patiente,
  });

  final String? nome;
  final String? sobrenome;

  final PatienteModel? patiente;

  SelfServiceModel clear() {
    return copyWith(
      nome: () => '',
      sobrenome: () => '',
      patiente: () => null,
    );
  }

  SelfServiceModel copyWith({
    ValueGetter<String?>? nome,
    ValueGetter<String?>? sobrenome,
    ValueGetter<PatienteModel?>? patiente,
  }) {
    return SelfServiceModel(
      nome: nome != null ? nome() : this.nome,
      sobrenome: sobrenome != null ? sobrenome() : this.sobrenome,
      patiente: patiente != null ? patiente() : this.patiente,
    );
  }
}
