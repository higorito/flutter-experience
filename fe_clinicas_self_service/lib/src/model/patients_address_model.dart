import 'package:json_annotation/json_annotation.dart';

part 'patients_address_model.g.dart';

@JsonSerializable()
class PatientsAddressModel {
  PatientsAddressModel({
    required this.cep,
    required this.number,
    required this.complement,
    required this.streetAddress,
    required this.state,
    required this.city,
    required this.district,
  });

  final String cep;
  @JsonKey(name: 'street_address', defaultValue: '')
  final String streetAddress;
  final String number;
  @JsonKey(name: 'address_complement', defaultValue: '')
  final String complement;
  final String state;
  final String city;
  final String district;

  //pra n dar erro precisa rodar o dart pub run build_runner watch -d no terminal e deixar rodando
  //escuta o projeto e ja vai compilando, deixando em cache...
  factory PatientsAddressModel.fromJson(Map<String, dynamic> json) =>
      _$PatientsAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientsAddressModelToJson(this);

  PatientsAddressModel copyWith({
    String? cep,
    String? streetAddress,
    String? number,
    String? complement,
    String? state,
    String? city,
    String? district,
  }) {
    return PatientsAddressModel(
      cep: cep ?? this.cep,
      streetAddress: streetAddress ?? this.streetAddress,
      number: number ?? this.number,
      complement: complement ?? this.complement,
      state: state ?? this.state,
      city: city ?? this.city,
      district: district ?? this.district,
    );
  }
}
