import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:flutter/material.dart';

class DocumentBoxWidget extends StatelessWidget {
  const DocumentBoxWidget({
    super.key,
    required this.uploaded,
    required this.icon,
    required this.labels,
    required this.totalFiles,
    this.onTap,
  });

  final bool uploaded;
  final Widget icon;
  final String labels;
  final int totalFiles;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final totalFileLabel = totalFiles > 0 ? '($totalFiles)' : '';
    return Expanded(
        child: InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: uploaded ? ClinicasTheme.lightOrange : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ClinicasTheme.orangeColor),
        ),
        child: Column(
          children: [
            Expanded(child: icon),
            Text('$labels $totalFileLabel ',
                style: const TextStyle(
                  fontSize: 15,
                  color: ClinicasTheme.orangeColor,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    ));
  }
}
