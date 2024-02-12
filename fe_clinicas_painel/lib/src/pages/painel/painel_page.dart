import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_painel/src/models/painel_checkin_model.dart';
import 'package:fe_clinicas_painel/src/pages/painel/painel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'widgets/painel_principal_widget.dart';
import 'widgets/password_tile_widget.dart';

class PainelPage extends StatefulWidget {
  const PainelPage({super.key});

  @override
  State<PainelPage> createState() => _PainelPageState();
}

class _PainelPageState extends State<PainelPage> {
  final controller = Injector.get<PainelCotroller>();

  @override
  void initState() {
    controller.listenerPainel();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PainelCheckinModel? current;
    final PainelCheckinModel? lastCall;
    final List<PainelCheckinModel> others;

    final listPainel = controller.painelData.watch(context);

    current = listPainel.firstOrNull;
    if (listPainel.isNotEmpty) {
      listPainel.removeAt(0);
    }

    lastCall = listPainel.firstOrNull;
    if (listPainel.isNotEmpty) {
      listPainel.removeAt(0);
    }

    others = listPainel;

    return Scaffold(
      appBar: ClinicasAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                lastCall != null
                    ? SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        child: PainelPrincipalWidget(
                          passwordLabel: 'Senha Anterior',
                          password: lastCall.password,
                          deskNumber:
                              lastCall.attendantDesk.toString().padLeft(2, '0'),
                          labelColor: ClinicasTheme.blueColor,
                          btnColor: ClinicasTheme.orangeColor,
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(
                  width: 22,
                ),
                current != null
                    ? SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        child: PainelPrincipalWidget(
                          passwordLabel: 'Senha Atual',
                          password: current.password,
                          deskNumber:
                              current.attendantDesk.toString().padLeft(2, '0'),
                          labelColor: ClinicasTheme.orangeColor,
                          btnColor: ClinicasTheme.blueColor,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            const SizedBox(
              height: 28,
            ),
            const Divider(
              color: ClinicasTheme.orangeColor,
              thickness: 1,
            ),
            const Text(
              'Histórico de Senhas',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ClinicasTheme.orangeColor),
            ),
            const SizedBox(
              height: 16,
            ),
            Wrap(
              runAlignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: others
                  .map(
                    (p) => PasswordTileWidget(
                      password: p.password,
                      deskNumber: p.attendantDesk.toString(),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
