import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:runard/parcours_dto.dart';
import 'package:runard/parcoursliste.dart';
import 'package:runard/points_dto.dart';
import 'gpx_parse.dart';
import 'dbhelper.dart';
import 'home.dart';
import 'package:tuple/tuple.dart';
import 'import.dart';

class SingleMap extends StatelessWidget {

  Future<List<PointsDTO>> callAsyncFetch() async {
    final parcoursget = await DbHelper.instance.getLatestParcours(this.id);
    final parcoursgetpoints = await parcoursget.item1;
    return parcoursgetpoints;
  }
  Future<List<ParcoursDTO>> callAsyncFetchparcour() async {
    final parcoursget = await DbHelper.instance.getLatestParcours(this.id);
    final parcoursgetparcours = await parcoursget.item2;
    return parcoursgetparcours;
  }


  int? id;

  SingleMap({required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( // Bar menu
          centerTitle: false,
          titleSpacing: 0.0,
          backgroundColor: Color(0xFF001420),
          actions: <Widget>[

          ],
        ),
        drawer: Drawer(
          backgroundColor: Color(0xFF005F8F),
          child: ListView(
            children: <Widget>[
              DrawerHeader(

                decoration: BoxDecoration(

                ),
                child: Image.asset("assets/test.png", height: 4000, width: 400000,),
              ),
              ListTile(
                title: Text("Accueil", style: TextStyle(fontSize: 20,color: Colors.white)),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                },
              ),
              ListTile(
                title: Text("Liste des parcours", style: TextStyle(fontSize: 20,color: Colors.white)),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ParcoursListe()));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.add_circle_outline),
                    SizedBox(width: 10),
                    Text("Importer", style: TextStyle(fontSize: 20,color: Colors.white)),
                  ],
                ),
                onTap: () {
                  print("hello");
                  openFiles();
                },
              ),
            ],
          ),
        ),
        body:

          Center(

             child :Container(
            decoration: BoxDecoration(
              color: Color(0xFF001420),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),

            ),

            child: Column(

              children: [
                SizedBox(
                  child: GPXMap(points: callAsyncFetch()),
                  height: 400,
                  width: 350,
                ),
                FutureBuilder<List<ParcoursDTO>>(
                  future: callAsyncFetchparcour(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<ParcoursDTO>> snapshot) {
                    if (snapshot.hasData) {
                      final temps = snapshot.data![0].temps.toString();
                      final km = snapshot.data![0].km.toString();
                      final vitesse = snapshot.data![0].vitesse.toString();
                      final nom = snapshot.data![0].nom.toString();
                      return SizedBox(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(nom, style: TextStyle(fontSize: 20, color: Colors.white),),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Temps : "+temps, style: TextStyle(fontSize: 20, color: Colors.white),),
                            Text("Distance : "+km+"km",style: TextStyle(fontSize: 20, color: Colors.white),),
                            Text("Vitesse : "+vitesse,style: TextStyle(fontSize: 20, color: Colors.white),),
                        ]),


                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),

              ],
            ),
            width: 350.0,
            height: 550.0,
            padding: EdgeInsets.only(top: 15.0, left: 0.0),
          ),

        ),backgroundColor: Color(0xFF386E8F),);



  }
}