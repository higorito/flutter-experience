import 'package:fe_clinicas_desktop/src/pages/checkin/checkin_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

import '../../models/patiente_information_form_model.dart';
import 'checkin_page.dart';

class CheckinRouter extends FlutterGetItPageRouter {
  const CheckinRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton(
          (i) => CheckinController(patientInformationFormRepository: i()),
        ),
      ];

  @override
  String get routeName => '/checkin';

  @override
  WidgetBuilder get view => (context) {
        final form = ModalRoute.of(context)!.settings.arguments
            as PatienteInformationFormModel;

        // ou Injector.get() mesma coisa
        context.get<CheckinController>().informationForm.value = form;
        //basicamente pega o value de informationForm e passa para a pagina
        return const CheckinPage();
      };
}
