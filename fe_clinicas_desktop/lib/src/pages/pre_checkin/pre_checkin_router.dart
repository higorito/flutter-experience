import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

import 'pre_checkin_page.dart';

class PreCheckinRouter extends FlutterGetItPageRouter {
  const PreCheckinRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [];

  @override
  String get routeName => '/pre-checkin';

  @override
  WidgetBuilder get view => (_) => const PreCheckinPage();
}
