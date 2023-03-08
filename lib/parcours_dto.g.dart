// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parcours_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParcoursDTO _$ParcoursDTOFromJson(Map<String, dynamic> json) => ParcoursDTO(
      json['parcoursid'] as int?,
      json['nom'] as String?,
      json['date'] as String?,
    );

Map<String, dynamic> _$ParcoursDTOToJson(ParcoursDTO instance) =>
    <String, dynamic>{
      'parcoursid': instance.parcoursid,
      'nom': instance.nom,
      'date': instance.date,
    };
