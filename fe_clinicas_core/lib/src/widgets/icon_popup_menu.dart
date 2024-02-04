import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:flutter/material.dart';

class IconPopupMenu extends StatelessWidget {
  const IconPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18.0),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ClinicasTheme.orangeColor, width: 2),
        ),
        child: const Icon(
          Icons.more_horiz_sharp,
          color: ClinicasTheme.orangeColor,
        ),
      ),
    );
  }
}
