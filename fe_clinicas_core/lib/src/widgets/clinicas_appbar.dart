import 'package:flutter/material.dart';

class ClinicasAppbar extends AppBar {
  ClinicasAppbar({super.key, List<Widget>? actions})
      : super(
          backgroundColor: Colors.transparent,
          toolbarHeight: 70,
          flexibleSpace: Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.47),
                  blurRadius: 4,
                  // spreadRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 32.0),
              child: Image.asset('assets/images/logo_horizontal.png'),
            ),
          ),
          actions: actions,
        );
}
