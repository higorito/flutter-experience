import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:flutter/material.dart';

class DataItem extends StatelessWidget {
  const DataItem({
    super.key,
    required this.label,
    required this.value,
    this.padding,
  });

  final String label;
  final String value;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    //Widget para forçar ser o pai  de todos os widgets(tipos)
    Widget widget = Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            color: ClinicasTheme.blueColor,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: ClinicasTheme.orangeColor,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );

    if (padding != null) {
      widget = Padding(
        padding: padding!,
        child: widget,
      );
    }
    return widget;
  }
}
