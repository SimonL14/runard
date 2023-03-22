// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parcours_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParcoursDTO _$ParcoursDTOFromJson(Map<String, dynamic> json) => ParcoursDTO(
      json['parcoursid'] as int?,
      json['nom'] as String?,
      json['date'] as String?,
      json['temps'] as String?,
      json['km'] as String?,
      json['vitesse'] as String?,
    );

Map<String, dynamic> _$ParcoursDTOToJson(ParcoursDTO instance) =>
    <String, dynamic>{
      'parcoursid': instance.parcoursid,
      'nom': instance.nom,
      'date': instance.date,
      'temps': instance.temps,
      'km': instance.km,
      'vitesse': instance.vitesse,
    };
