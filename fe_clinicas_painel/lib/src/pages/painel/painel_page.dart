import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:flutter/material.dart';

import 'widgets/painel_principal_widget.dart';
import 'widgets/password_tile_widget.dart';

class PainelPage extends StatelessWidget {
  const PainelPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  child: PainelPrincipalWidget(
                    passwordLabel: 'Senha Anterior',
                    password: '1234',
                    deskNumber: '1',
                    labelColor: ClinicasTheme.blueColor,
                    btnColor: ClinicasTheme.orangeColor,
                  ),
                ),
                const SizedBox(
                  width: 22,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  child: PainelPrincipalWidget(
                    passwordLabel: 'Senha Atual',
                    password: '1234',
                    deskNumber: '2',
                    labelColor: ClinicasTheme.orangeColor,
                    btnColor: ClinicasTheme.blueColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 28,
            ),
            Divider(
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
            const Wrap(
              runAlignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: [
                PasswordTileWidget(),
                PasswordTileWidget(),
                PasswordTileWidget(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
