import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Class qui permet de centralser la connexion, la création de la base de donnée
class DbHelper{
  // Création de constantes (dbName = nom base de donnée // dbPathName = nom du fichier sur le tel qui stock les données // dbVersion = version de la bdd)
  static const dbName = 'runard.db'; // nom schema
  static const dbPathName = 'runard.path'; // nom du fichier sur le tel
  static const dbVersion = 13; // numéro de version du schema (pour les upgrades)

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

    //Ajout d'une clé étrangère sur le parcoursid
    //const String alterpointsTable ='ALTER TABLE points ADD KEY parcoursid (parcoursid)';
    //db.execute(alterpointsTable);

    //const String createContraiteParcours ='ALTER TABLE points ADD CONSTRAINT points_parcoursid FOREIGN KEY (parcoursid) REFERENCES parcours (id)';
    //db.execute(createContraiteParcours);
    //print(createContraiteParcours);
    //print('Création de la Contrainte');
  }

  //Déclenché losque le numéro de version est augmenté
  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion){
    // Pour simplifié, on drop les tables ici
    // NE PAS FAIRE EN PRODUCTION !!!!!!!! (sauf avec un adulte...)
    const String dropWordsTableQuery = 'DROP TABLE IF EXISTS words';
    db.execute(dropWordsTableQuery);

    //On recréer la db avec la nouvelle version
    _onCreate(db, newVersion);
  }

  //Permet d'insert dans une base de donnée
  Future<void> insert() async{
    //Récupération de l'instance de la db
    Database db = await instance.database;
    print('insert ok');
  }
}