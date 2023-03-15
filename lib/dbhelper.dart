import 'dart:async';
import 'package:path/path.dart';
import 'package:runard/parcours_dto.dart';
import 'package:runard/points_dto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tuple/tuple.dart';

// Class qui permet de centralser la connexion, la création de la base de donnée
class DbHelper{
  // Création de constantes (dbName = nom base de donnée // dbPathName = nom du fichier sur le tel qui stock les données // dbVersion = version de la bdd)
  static const dbName = 'runard.db'; // nom schema
  static const dbPathName = 'runard.path'; // nom du fichier sur le tel
  static const dbVersion = 20; // numéro de version du schema (pour les upgrades)

  //Instance de connexion à la base de donnée
  static Database? _database;

  //Constructeur de DbHelper
  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();

  // Si "_database" n'existe pas le "_initDatabase()" vas l'initialiser // getter de la base de donnée
  Future<Database> get database async => _database ??= await _initDatabase();

  // Création de la database
  Future<Database> _initDatabase() async{
    // On utilise path pour récup un emplacement de stockage
    final String dbPath = await getDatabasesPath();
    //On ouvre la connexion
    return await openDatabase(
      join(dbPath, dbPathName),
      version: dbVersion,
      //onCreate permet de créer la base de donnée si elle existe pas
      onCreate: _onCreate,
      //onUpgrade permet d'augmenter le schéma de la bdd vers la nouvelle version
      onUpgrade: _onUpgrade,
    );
  }

  //Déclenché lorsque la base de données n'existe pas sur le tel
  Future _onCreate(Database db, int version) async{

    //Table parcours qui possède les infos sur le parcours
    const String createParcoursTableQuery = 'CREATE TABLE parcours (id integer PRIMARY KEY AUTOINCREMENT, nom VARCHAR(200) NOT NULL, date VARCHAR(200) NOT NULL)';
    db.execute(createParcoursTableQuery);
    print('Création de la table Parcours');

    //Table Points qui possède les points du fichier gpx
    const String createPointsTableQuery = 'CREATE TABLE points (id integer PRIMARY KEY AUTOINCREMENT, lat VARCHAR(200) NOT NULL, long VARCHAR(200) NOT NULL, ele VARCHAR(200) NOT NULL, time VARCHAR(200) NOT NULL, parcoursid integer NOT NULL, FOREIGN KEY(parcoursid) REFERENCES parcours(id))';
    db.execute(createPointsTableQuery);
    print('Création de la table points');
  }

  //Déclenché losque le numéro de version est augmenté
  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion){
    // Pour simplifié, on drop les tables ici
    // NE PAS FAIRE EN PRODUCTION !!!!!!!! (sauf avec un adulte...)
    //const String dropWordsTableQuery = '';
    //db.execute(dropWordsTableQuery);

    //On recréer la db avec la nouvelle version
    _onCreate(db, newVersion);
  }

  //Permet d'insert dans une base de donnée
  Future<void> insertParcours(final ParcoursDTO parcoursDTO) async{
    //Récupération de l'instance de la db
    Database db = await instance.database;
    final String insertParcours = "INSERT into parcours (id,nom,date) values (${parcoursDTO.parcoursid},'${parcoursDTO.nom}','${parcoursDTO.date}')";
    var execute = db.execute(insertParcours);
    return execute;
  }

  //Permet d'insert dans une base de donnée
  Future<void> insertPoints(final PointsDTO pointsDTO) async{
    //Récupération de l'instance de la db
    Database db = await instance.database;
    final String insertPoints = "INSERT into points (id,lat,long,ele,time,parcoursid) values (${pointsDTO.id},'${pointsDTO.lat}','${pointsDTO.long}','${pointsDTO.ele}','${pointsDTO.time}',${pointsDTO.parcoursid})";
    var execute = db.execute(insertPoints );
    return execute;
  }

  Future<int> getLastParcoursId() async {
    Database db = await instance.database;
    final getParcoursId = await db.rawQuery("Select max(id) FROM parcours");
    return getParcoursId[0]['max(id)'] as int;
  }

  //Permet de récupérer la liste des parcours
  Future<Tuple2<Future<List<PointsDTO>>, Future<List<ParcoursDTO>>>> getAllParcours() async {
    //Récupération de l'instance de la db
    Database db = await instance.database;

    // execution query
    final resultSet = await db.rawQuery("SELECT * from parcours INNER JOIN  points on parcours.id = points.parcoursid");

    // On initialise un liste de parcours vide
    final List<PointsDTO> resultspts = <PointsDTO>[];
    final List<ParcoursDTO> resultsparc = <ParcoursDTO>[];

    print(resultSet);
    //On parcours les résultats
    for (var r in resultSet){
      // on instancie un ParcoursDTO sur la base de r
      var parcourpts = PointsDTO.fromMap(r);
      // on l'ajoute sand la liste de resultat
      resultspts.add(parcourpts);
      if (
          int.parse(resultSet[int.parse(r['id'].toString())-1]['id'].toString())! < resultSet.length-1
          && resultSet[int.parse(r['id'].toString())]['parcoursid'] != resultSet[int.parse(r['id'].toString())-1]['parcoursid']
          || resultSet[int.parse(r['id'].toString())-1]['id'] == 1)
      {
        // on instancie un ParcoursDTO sur la base de r
        var parcourparc = ParcoursDTO.fromMap(resultSet[int.parse(r['id'].toString())]);
        // on l'ajoute sand la liste de resultat
        resultsparc.add(parcourparc);
      }
    }
    // On retourne la liste de résultats
    return Tuple2(Future.value(resultspts),Future.value(resultsparc));

  }

  //Obtenir le dernier parcours
  Future<Tuple2<Future<List<PointsDTO>>, Future<List<ParcoursDTO>>>> getLatestParcours(lastParcoursId) async {
    //Récupération de l'instance de la db
    Database db = await instance.database;
    print('requete : ${lastParcoursId}');

    // execution query
    final getlastparcours = await db.rawQuery("SELECT * from parcours INNER JOIN  points on parcours.id = points.parcoursid WHERE points.parcoursid = ${lastParcoursId}");

    // On initialise un liste de parcours vide
    final List<PointsDTO> resultLastPoints = <PointsDTO>[];
    final List<ParcoursDTO> resultLastParcours = <ParcoursDTO>[];

    print('requete : ${getlastparcours}');

    //On parcours les résultats
    for (var r in getlastparcours) {
      // on instancie un ParcoursDTO sur la base de r
      var lastparcourspoints = PointsDTO.fromMap(r);
      // on l'ajoute sand la liste de resultat
      resultLastPoints.add(lastparcourspoints);

      // on instancie un ParcoursDTO sur la base de r
      var lastparcoursparcours = ParcoursDTO.fromMap(r);
      // on l'ajoute sand la liste de resultat
      resultLastParcours.add(lastparcoursparcours);
    }
    return Tuple2(Future.value(resultLastPoints),Future.value(resultLastParcours));

  }

  Future<List<PointsDTO>>getAllPointsParcours(parcoursid) async{
    Database db = await instance.database;
    final getAllPoints = await db.rawQuery("SELECT * from points WHERE points.parcoursid = ${parcoursid}");
    final List<PointsDTO> allPoints = <PointsDTO>[];
    for (var r in getAllPoints) {
      var parcourspoints = PointsDTO.fromMap(r);
      allPoints.add(parcourspoints);
    }
    return allPoints;
  }

  //Permet de supprimer
  Future<void> deleteParcours(id) async{
    //Récupération de l'instance de la db
    Database db = await instance.database;
    final String suppPoints = "DELETE * FROM points WHERE parcoursid = ${id}";
    final String suppParcours = "DELETE FROM parcours WHERE id = ${id}";
    db.execute(suppPoints);
    db.execute(suppParcours);
  }


  //Permet de modifier un point du parcours
  Future<void> modifPoints(id, newLat, newLon, newEle) async{
    //Récupération de l'instance de la db
    Database db = await instance.database;
    final String modifParcours = "UPDATE points SET lat = ${newLat}, long = ${newLon}, ele = ${newEle} WHERE id = ${id}";
    db.execute(modifParcours);
    print("requete modif dbhelp");
  }

}