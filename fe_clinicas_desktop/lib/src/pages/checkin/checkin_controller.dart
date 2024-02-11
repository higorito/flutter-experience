import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../models/patiente_information_form_model.dart';

class CheckinController with MessagesStateMixin {
  final informationForm = signal<PatienteInformationFormModel?>(null);
}
