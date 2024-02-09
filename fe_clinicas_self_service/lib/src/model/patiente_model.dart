import 'package:fe_clinicas_self_service/src/model/patients_address_model.dart';
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

  final String id;
  final String name;
  final String email;
  @JsonKey(name: "phone_number")
  final String phoneNumber;
  final String document;
  final PatientsAddressModel address;
  @JsonKey(name: 'guardian', defaultValue: '') //se n tiver valor vai da erro
  final String guardian;
  @JsonKey(name: 'guardian_identification_number', defaultValue: '')
  final String guardianIdentificationNumber;

  //msm coisa aqui o build_runner dart pub run build_runner watch -d
  factory PatienteModel.fromJson(Map<String, dynamic> json) =>
      _$PatienteModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatienteModelToJson(this);

  PatienteModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? document,
    PatientsAddressModel? address,
    String? guardian,
    String? guardianIdentificationNumber,
  }) {
    return PatienteModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      document: document ?? this.document,
      address: address ?? this.address,
      guardian: guardian ?? this.guardian,
      guardianIdentificationNumber:
          guardianIdentificationNumber ?? this.guardianIdentificationNumber,
    );
  }
}
