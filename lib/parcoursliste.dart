import 'package:flutter/material.dart';
import 'gpx_parse.dart';
import 'dbhelper.dart';
import 'home.dart';

class ParcoursListe extends StatelessWidget {

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
          ],
        ),
      ),

      body: Center(
    child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 10),
            Container(
              width: 350.0,
              height: 220.0,
              decoration: BoxDecoration(
                color: Color(0xFF001420),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              padding: EdgeInsets.only(top: 5.0, left: 0.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("    Nom du parcours (Date)", style: TextStyle(fontSize: 20,color: Colors.white)),
                  ),
                  SizedBox(height: 10),
                  SizedBox(child: GPXMap(), height: 172, width: 348,),

                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 350.0,
              height: 220.0,
              decoration: BoxDecoration(
                color: Color(0xFF001420),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              padding: EdgeInsets.only(top: 5.0, left: 0.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("    Nom du parcours (Date)", style: TextStyle(fontSize: 20,color: Colors.white)),
                  ),
                  SizedBox(height: 10),
                  SizedBox(child: GPXMap(), height: 172, width: 348,),

                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 350.0,
              height: 220.0,
              decoration: BoxDecoration(
                color: Color(0xFF001420),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              padding: EdgeInsets.only(top: 5.0, left: 0.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("    Nom du parcours (Date)", style: TextStyle(fontSize: 20,color: Colors.white)),
                  ),
                  SizedBox(height: 10),
                  SizedBox(child: GPXMap(), height: 172, width: 348,),

                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 350.0,
              height: 220.0,
              decoration: BoxDecoration(
                color: Color(0xFF001420),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              padding: EdgeInsets.only(top: 5.0, left: 0.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("    Nom du parcours (Date)", style: TextStyle(fontSize: 20,color: Colors.white)),
                  ),
                  SizedBox(height: 10),
                  SizedBox(child: GPXMap(), height: 172, width: 348,),

                ],
              ),
            ),
          ],
        ),
        )
      ),
      backgroundColor: Color(0xFF386E8F),
    );
  }
}