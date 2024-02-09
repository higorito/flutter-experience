import 'package:asyncstate/asyncstate.dart';
import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_self_service/src/model/patiente_model.dart';
import 'package:fe_clinicas_self_service/src/model/self_service_model.dart';
import 'package:fe_clinicas_self_service/src/repositories/information_form/information_form_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

enum FormSteps {
  none,
  nomes,
  paciente,
  valpaciente,
  documentos,
  done,
  restart,
}

class SelfServiceController with MessagesStateMixin {
  SelfServiceController({
    required this.informationFormRepository,
  });

  //o repo de informação q vai ser usaod no done
  final IInformationFormRepository informationFormRepository;

  final _step = ValueSignal(FormSteps.none);
  FormSteps get step => _step();

  var _model = SelfServiceModel();
  SelfServiceModel get model => _model;

  var password = '';

  void startProcess() {
    //se for o msm objeto ele n vai atualizar, ai precisa forçar
    _step.forceUpdate(FormSteps.nomes);
  }

  void setNomesDataAndNextStep(String nome, String sobrenome) {
    _model = _model.copyWith(
      nome: () => nome,
      sobrenome: () => sobrenome,
    );
    _step.forceUpdate(FormSteps.paciente);
  }

  //VALIDAÇÃO PACIENTE

  void clearForm() {
    _model = _model.clear();
  }

  void goFormPatientAndNextStep(PatienteModel? patiente) {
    _model = _model.copyWith(
      patiente: () => patiente,
    );

    _step.forceUpdate(FormSteps.valpaciente);
  }

  void restartProcess() {
    _step.forceUpdate(FormSteps.restart);
    clearForm();
  }

  void updatePatienteAndGoDocument(PatienteModel? patiente) {
    _model = _model.copyWith(
      patiente: () => patiente,
    );

    _step.forceUpdate(FormSteps.documentos);
  }

  //DOCUMENTOS

  void registerDocument(DocumentType type, String filePath) {
    final documents = _model.documents ?? {};
    if (type == DocumentType.carteirinha) {
      documents[type]?.clear();
    }

    final values = documents[type] ?? [];
    values.add(filePath);
    documents[type] = values;
    _model = _model.copyWith(
      documents: () => documents,
    );
  }

  void clearDocuments() {
    _model = _model.copyWith(
      documents: () => {},
    );
  }

  Future<void> finalize() async {
    final result =
        await informationFormRepository.register(_model).asyncLoader();

    switch (result) {
      case Left():
        showError('Erro ao finalizar');
      case Right():
        password =
            '${_model.nome} ${_model.sobrenome}'; //aq eu posso gerar outras coisas
        _step.forceUpdate(FormSteps.done);
    }
  }
}
