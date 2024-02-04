import 'package:fe_clinicas_core/fe_clinicas_core.dart';

class HomeController with MessagesStateMixin {
  //adiciona o mixin para ter acesso ao metodo showError e tmb cria la na outra chasse o MessagesViewMixin
  void fazerAlgo() {
    showError('NAO SEI');
  }
}
