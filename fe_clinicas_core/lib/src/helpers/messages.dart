import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

final class Messages {
  static void showError(String message, BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(message: message),
    );
  }

  static void showSuccess(String message, BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(message: message),
    );
  }

  static void showInfo(String message, BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(message: message),
    );
  }
}

//mixin é um conceito de herança múltipla, atraves do mixin é possivel adicionar metodos e propriedades a uma classe
// ai depois so chama com o with, fazer isso pra conseguir usar o showTopSnackBar em qualquer lugar

mixin MessagesStateMixin {
  //variaveis de estado
  //getters
  final Signal<String?> _errorMessage = signal(null);
  String? get errorMessage =>
      _errorMessage(); //n pode ser alterado de qlq lugar, mas pode ser lido

  final Signal<String?> _successMessage = signal(null);
  String? get successMessage => _successMessage();

  final Signal<String?> _infoMessage = signal(null);
  String? get infoMessage => _infoMessage();
  //limpeza
  void clearError() => _errorMessage.value = null;
  void clearSuccess() => _successMessage.value = null;
  void clearInfo() => _infoMessage.value = null;
  void clearAllMessages() {
    untracked(() {
      clearError();
      clearSuccess();
      clearInfo();
    });
  }

  //setters
  void showError(String message) {
    untracked(() =>
        clearError()); //limpa a mensagem de erro, mas avisa, entao passa o untracked pra n avisar
    _errorMessage.value = message;
  }

  void showSuccess(String message) {
    untracked(() => clearSuccess());
    _successMessage.value = message;
  }

  void showInfo(String message) {
    untracked(() => clearInfo());
    _infoMessage.value = message;
  }
}

mixin MessagesViewMixin<T extends StatefulWidget> on State<T> {
  void messageListener(MessagesStateMixin state) {
    effect(() {
      //fica escutando o estado
      switch (state) {
        case MessagesStateMixin(:final errorMessage?):
          Messages.showError(errorMessage, context);
        case MessagesStateMixin(:final successMessage?):
          Messages.showSuccess(successMessage, context);
        case MessagesStateMixin(:final infoMessage?):
          Messages.showInfo(infoMessage, context);
      }
    });
  }
}
