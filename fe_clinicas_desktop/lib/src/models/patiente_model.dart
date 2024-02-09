import 'package:fe_clinicas_desktop/src/models/patient_address_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patiente_model.g.dart';

@JsonSerializable()
class PatienteModel {
  PatienteModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.document,
    required this.address,
    required this.guardian,
    required this.guardianIdentificationNumber,
  });

  String id;
  String name;
  String email;
  @JsonKey(name: 'phone_number')
  String phoneNumber;
  String document;
  PatientAddressModel address;
  @JsonKey(defaultValue: '')
  String guardian;
  @JsonKey(name: 'guardian_identification_number', defaultValue: '')
  String guardianIdentificationNumber;

  factory PatienteModel.fromJson(Map<String, dynamic> json) =>
      _$PatienteModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatienteModelToJson(this);
}
