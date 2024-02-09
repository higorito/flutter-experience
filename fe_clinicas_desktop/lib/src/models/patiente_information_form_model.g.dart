// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patiente_information_form_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatienteInformationFormModel _$PatienteInformationFormModelFromJson(
        Map<String, dynamic> json) =>
    PatienteInformationFormModel(
      id: json['id'] as String,
      patient: PatienteModel.fromJson(json['patient'] as Map<String, dynamic>),
      healthInsuranceCard: json['health_insurance_card'] as String,
      medicalOrder: (json['medical_order'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      password: json['password'] as String,
      dateCreated: DateTime.parse(json['date_created'] as String),
      status:
          $enumDecode(_$PatienteInformationFormStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$PatienteInformationFormModelToJson(
        PatienteInformationFormModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patient': instance.patient,
      'health_insurance_card': instance.healthInsuranceCard,
      'medical_order': instance.medicalOrder,
      'password': instance.password,
      'date_created': instance.dateCreated.toIso8601String(),
      'status': _$PatienteInformationFormStatusEnumMap[instance.status]!,
    };

const _$PatienteInformationFormStatusEnumMap = {
  PatienteInformationFormStatus.waiting: 'Waiting',
  PatienteInformationFormStatus.checkIn: 'Checked In',
  PatienteInformationFormStatus.beingAttended: 'Being Attended',
};
