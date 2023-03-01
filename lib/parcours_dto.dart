import 'package:freezed_annotation/freezed_annotation.dart';

part 'parcours_dto.g.dart';

@JsonSerializable() // Permet de générer des méthodes from et toJson
class ParcoursDTO{
  //Constructeur
  ParcoursDTO(this.parcoursid, this.nom, this.date);

  // Attributs // int? ou String? permet de dire que les attributs peuvent être null
  final int? parcoursid;
  final String? nom;
  final String? date;

  Map<String, dynamic> toJson() => _$ParcoursDTOToJson(this);

  factory ParcoursDTO.fromJson(Map<String, dynamic> json) => _$ParcoursDTOFromJson(json);

  //Permet de créer un PointsDTO avec le resultat d'une requete SQLite
  static fromMap(Map<String, dynamic> map) => ParcoursDTO.fromJson(map);
}

