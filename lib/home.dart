import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'gpx_parse.dart';
import 'dbhelper.dart';

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    backgroundColor: Color(0xFF0386E8F);
    final ButtonStyle style = TextButton.styleFrom(
      // Changer couleur bouton ou police
    );
    //Permet de tester la base de donnée
    DbHelper.instance.insert();


    return Scaffold(

      appBar: AppBar( // Bar menu
        centerTitle: false,
        titleSpacing: 0.0,
        title:  Transform(
          // you can forcefully translate values left side using Transform
          transform:  Matrix4.translationValues(-50.0, 0.0, 0.0),
          child: Image.asset("assets/logo_151_bon.png", height: 185, width: 185,),
        ),
        backgroundColor: Color(0xFF001420),
        actions: <Widget>[
        TextButton(
        style: style,
        onPressed: () {},
        child: const Icon(Icons.dehaze),
        ),
        ],
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



            Container(
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