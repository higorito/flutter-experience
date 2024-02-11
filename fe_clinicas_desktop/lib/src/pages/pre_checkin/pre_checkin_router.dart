import 'package:fe_clinicas_desktop/src/pages/pre_checkin/pre_chekin_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

import '../../models/patiente_information_form_model.dart';
import 'pre_checkin_page.dart';

class PreCheckinRouter extends FlutterGetItPageRouter {
  const PreCheckinRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton(
          (i) => (PreChekinController(
            callNextPatientService: i(),
          )),
        ),
      ];

  @override
  String get routeName => '/pre-checkin';

  @override
  WidgetBuilder get view => (context) {
        //vai implementar o metodo antes de retornar a pagina
        //tela anterior usou um parametro para passar o informationForm

        final form = ModalRoute.of(context)!.settings.arguments
            as PatienteInformationFormModel;

        // ou Injector.get() mesma coisa
        context.get<PreChekinController>().informationForm.value = form;
        //basicamente pega o value de informationForm e passa para a pagina
        return const PreCheckinPage();
      };
}
