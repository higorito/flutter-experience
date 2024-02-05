import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: ClinicasAppbar(
        actions: [
          PopupMenuButton<int>(
            child: const IconPopupMenu(),
            itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text('Iniciar terminal'),
                ),
                const PopupMenuItem<int>(
                  value: 2,
                  child: Text('Encerrar terminal'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: size.width > 600
              ? const EdgeInsets.only(top: 150)
              : const EdgeInsets.only(top: 80),
          padding: const EdgeInsets.all(38),
          width: size.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ClinicasTheme.orangeColor, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.47),
                blurRadius: 4,
                // spreadRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Bem Vindo! ',
                style: ClinicasTheme.titleStyle,
              ),
              const Text('Auto Atendimento',
                  style: ClinicasTheme.subtitleStyle),
              SizedBox(height: size.height * 0.03),
              SizedBox(
                width: size.width * 0.8,
                height: size.height * 0.045,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/self-service');
                  },
                  child: const Text('INICIAR ATENDIMENTO'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
