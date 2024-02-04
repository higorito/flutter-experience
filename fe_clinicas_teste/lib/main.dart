import 'package:asyncstate/asyncstate.dart';
import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_teste/home_crontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ClinicasCoreConfig(
      title: 'Clinicas Core',
      pagesBuilders: [
        FlutterGetItPageBuilder(page: (_) => HomePage(), path: '/'),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with MessagesViewMixin {
  final controller = HomeController();

  @override
  void initState() {
    messageListener(
        controller); //adiciona o listener para ouvir as mensagens do controller
    super.initState();
  }

  void teste() {
    Future.delayed(const Duration(seconds: 3)).asyncLoader();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clinicas Core'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                controller.fazerAlgo();
              },
              child: const Text('Fazer Algo'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: teste, child: const Text('loading')),
          ],
        ),
      ),
    );
  }
}
