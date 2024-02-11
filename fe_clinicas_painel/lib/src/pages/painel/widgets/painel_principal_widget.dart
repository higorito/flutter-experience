import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:flutter/material.dart';

class PainelPrincipalWidget extends StatelessWidget {
  const PainelPrincipalWidget({
    super.key,
    required this.passwordLabel,
    required this.password,
    required this.deskNumber,
    required this.labelColor,
    required this.btnColor,
  });

  final String passwordLabel;
  final String password;
  final String deskNumber;

  final Color labelColor;
  final Color btnColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(32),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ClinicasTheme.orangeColor),
        ),
        child: Column(
          children: [
            Text(
              passwordLabel,
              style: ClinicasTheme.titleStyle.copyWith(
                color: labelColor,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              decoration: BoxDecoration(
                color: btnColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: labelColor),
              ),
              child: Text(
                password,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Guichê',
              style: ClinicasTheme.titleStyle.copyWith(
                color: labelColor,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              decoration: BoxDecoration(
                color: btnColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: labelColor),
              ),
              child: Text(
                deskNumber,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
