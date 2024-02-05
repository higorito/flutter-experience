import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_self_service/src/modules/autoAtendimento/self_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class ClinicaSelfServiceAppbar extends ClinicasAppbar {
  ClinicaSelfServiceAppbar()
      : super(
          actions: [
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: 1,
                    child: Text('Reiniciar Terminal'),
                  ),
                ];
              },
              child: const IconPopupMenu(),
              onSelected: (value) async {
                if (value == 1) {
                  Injector.get<SelfServiceController>().restartProcess();
                }
              },
            )
          ],
        );
}
