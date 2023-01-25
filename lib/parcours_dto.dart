import 'package:freezed_annotation/freezed_annotation.dart';

part 'parcours_dto.g.dart';

@JsonSerializable() // Permet de générer des méthodes from et toJson
class ParcoursDTO{
  //Constructeur
  ParcoursDTO(this.id, this.nom, this.date);

  // Attributs // int? ou String? permet de dire que les attributs peuvent être null
  final int? id;
  final String? nom;
  final String? date;

  Map<String, dynamic> toJson() => _$ParcoursDTOToJson(this);

  factory ParcoursDTO.fromJson(Map<String, dynamic> json) => _$ParcoursDTOFromJson(json);

  //Permet de créer un WordDTO avec le resultat d'une requete SQLite
  static fromMap(Map<String, dynamic> map) => ParcoursDTO.fromJson(map);
}

