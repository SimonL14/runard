// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointsDTO _$PointsDTOFromJson(Map<String, dynamic> json) => PointsDTO(
      json['id'] as int?,
      json['lat'] as String?,
      json['long'] as String?,
      json['ele'] as String?,
      json['time'] as String?,
      json['parcoursid'] as int,
    );

Map<String, dynamic> _$PointsDTOToJson(PointsDTO instance) => <String, dynamic>{
      'id': instance.id,
      'lat': instance.lat,
      'long': instance.long,
      'ele': instance.ele,
      'time': instance.time,
      'parcoursid': instance.parcoursid,
    };
