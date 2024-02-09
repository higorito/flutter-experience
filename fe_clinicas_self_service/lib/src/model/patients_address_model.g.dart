// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patients_address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientsAddressModel _$PatientsAddressModelFromJson(
        Map<String, dynamic> json) =>
    PatientsAddressModel(
      cep: json['cep'] as String,
      number: json['number'] as String,
      complement: json['address_complement'] as String? ?? '',
      streetAddress: json['street_address'] as String? ?? '',
      state: json['state'] as String,
      city: json['city'] as String,
      district: json['district'] as String,
    );

Map<String, dynamic> _$PatientsAddressModelToJson(
        PatientsAddressModel instance) =>
    <String, dynamic>{
      'cep': instance.cep,
      'street_address': instance.streetAddress,
      'number': instance.number,
      'address_complement': instance.complement,
      'state': instance.state,
      'city': instance.city,
      'district': instance.district,
    };
