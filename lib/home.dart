import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:runard/parcoursliste.dart';
import 'package:runard/import.dart';
import 'gpx_parse.dart';
import 'dbhelper.dart';

class MyHomePage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    backgroundColor: Color(0xFF0386E8F);
    final ButtonStyle style = TextButton.styleFrom(
      // Changer couleur bouton ou police
    );
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 325.0,
              height: 300.0,
              decoration: BoxDecoration(
                color: Color(0xFF001420),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              padding: EdgeInsets.only(top: 10.0, left: 0.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("    Dernier parcours :", style: TextStyle(fontSize: 20,color: Colors.white)),
                  ),
                  SizedBox(height: 10),
                  SizedBox(child: GPXMap(), height: 212, width: 348,),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: Text("STATS", style: TextStyle(fontSize: 20,color: Colors.white)),
                  ),
                ],
              ),
            ),

        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ParcoursListe()));
          },
          child: Container(
            width: 325.0,
            height: 70.0,
            decoration: BoxDecoration(
              color: Color(0xFF001420),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child : Align(
              alignment: Alignment.center,
              child: Text("Tous les parcours", style: TextStyle(fontSize: 20,color: Colors.white)),
            ),
          ),
        ),

            Container(
              width: 325.0,
              height: 275.0,
              decoration: BoxDecoration(
                color: Color(0xFF001420),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF386E8F),
    );
  }
}