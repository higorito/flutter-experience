import 'package:fe_clinicas_desktop/src/models/patiente_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patiente_information_form_model.g.dart';

@JsonEnum(valueField: 'id')
enum PatienteInformationFormStatus {
  waiting('Waiting'),
  checkIn('Checked In'),
  beingAttended('Being Attended');

  final String id;
  const PatienteInformationFormStatus(this.id);
}

@JsonSerializable()
class PatienteInformationFormModel {
  PatienteInformationFormModel({
    required this.id,
    required this.patient,
    required this.healthInsuranceCard,
    required this.medicalOrder,
    required this.password,
    required this.dateCreated,
    required this.status,
  });

  final String id;
  final PatienteModel patient;
  @JsonKey(name: 'health_insurance_card')
  final String healthInsuranceCard;
  @JsonKey(name: 'medical_order')
  final List<String> medicalOrder;
  final String password;
  @JsonKey(name: 'date_created')
  final DateTime dateCreated;

  final PatienteInformationFormStatus status;

  factory PatienteInformationFormModel.fromJson(Map<String, dynamic> json) =>
      _$PatienteInformationFormModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatienteInformationFormModelToJson(this);
}
