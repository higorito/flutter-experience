import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_self_service/src/model/patiente_model.dart';
import 'package:fe_clinicas_self_service/src/model/self_service_model.dart';
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
  final _step = ValueSignal(FormSteps.none);
  FormSteps get step => _step();

  var _model = SelfServiceModel();
  SelfServiceModel get model => _model;

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
}
