import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:build_runner/build_runner.dart';

part 'points_dto.g.dart';

@JsonSerializable() // Permet de générer des méthodes from et toJson
class PointsDTO{
  //Constructeur
  PointsDTO(this.id, this.lat, this.long, this.ele, this.time, this.parcoursid);

  // Attributs // int? ou String? permet de dire que les attributs peuvent être null
  final int? id;
  final String? lat;
  final String? long;
  final String? ele;
  final String? time;
  final int parcoursid;

  Map<String, dynamic> toJson() => _$PointsDTOToJson(this);

  factory PointsDTO.fromJson(Map<String, dynamic> json) => _$PointsDTOFromJson(json);

  //Permet de créer un WordDTO avec le resultat d'une requete SQLite
  static fromMap(Map<String, dynamic> map) => PointsDTO.fromJson(map);
}