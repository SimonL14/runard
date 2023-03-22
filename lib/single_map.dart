import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:runard/parcoursliste.dart';
import 'gpx_parse.dart';
import 'dbhelper.dart';
import 'home.dart';

class SingleMap extends StatelessWidget {

  Future<int> id;

  SingleMap({required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( // Bar menu
          centerTitle: false,
          titleSpacing: 0.0,
          backgroundColor: Color(0xFF001420),
          actions: <Widget>[],
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
            ],
          ),
        ),
        body: Center(
          child: Container(
            width: 350.0,
            height: 450.0,
            decoration: BoxDecoration(
              color: Color(0xFF001420),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            padding: EdgeInsets.only(top: 5.0, left: 0.0),
            child: SizedBox(
              child: GPXMap(points: DbHelper.instance.getAllPointsParcoursfut(DbHelper.instance.getLastParcoursId()))
            ),
          ),
        ),


    );
  }
}