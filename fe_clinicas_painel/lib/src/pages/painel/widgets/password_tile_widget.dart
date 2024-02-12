import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:flutter/material.dart';

class PasswordTileWidget extends StatelessWidget {
  const PasswordTileWidget({
    super.key,
    required this.password,
    required this.deskNumber,
  });

  final String password;
  final String deskNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ClinicasTheme.orangeColor),
      ),
      child: Column(
        children: [
          Text(
            password,
            style: const TextStyle(
              color: ClinicasTheme.blueColor,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            'Guichê $deskNumber',
            style: const TextStyle(
                fontSize: 18,
                color: ClinicasTheme.orangeColor,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
