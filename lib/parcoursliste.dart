import 'package:flutter/material.dart';
import 'package:runard/parcours_dto.dart';
import 'package:runard/points_dto.dart';
import 'package:runard/single_map.dart';
import 'gpx_parse.dart';
import 'dbhelper.dart';
import 'home.dart';
import 'package:tuple/tuple.dart';

import 'import.dart';

class ParcoursListe extends StatelessWidget {

  Future<Tuple2<List<PointsDTO>, List<ParcoursDTO>>> callAsyncFetch() async {
    final parcoursget = await DbHelper.instance.getAllParcours();
    final parcoursgetpoints = await parcoursget.item1;
    final parcoursgetparcour = await parcoursget.item2;
    return Tuple2(parcoursgetpoints,parcoursgetparcour);
  }

  @override
  Widget build(context) {
    backgroundColor: Color(0xFF0386E8F);
    final ButtonStyle style = TextButton.styleFrom(
    );
    return FutureBuilder<Tuple2<List<PointsDTO>, List<ParcoursDTO>>>(
        future: callAsyncFetch(),
        builder: (context, AsyncSnapshot<Tuple2<List<PointsDTO>, List<ParcoursDTO>>> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar( // Bar menu
                centerTitle: false,
                titleSpacing: 0.0,
                backgroundColor: Color(0xFF001420),
                actions: <Widget>[IconButton(
                  icon: Icon(
                    Icons.filter_list,
                  ),
                  onPressed: () {},
                ),],
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i < snapshot.data!.item2.length; i++) ...{
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SingleMap(id: snapshot.data!.item2[i].parcoursid),
                              ),
                            );
                          },
                          child: Container(
                          width: 350.0,
                          height: 250.0,
                          decoration: BoxDecoration(
                            color: Color(0xFF001420),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          padding: EdgeInsets.only(top: 5.0, left: 0.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text("  "+snapshot.data!.item2[i].nom.toString(), style: TextStyle(fontSize: 20,color: Colors.white)),
                              ),
                              SizedBox(height: 10),

                              SizedBox(
                                child: GPXMap(points: DbHelper.instance.getAllPointsParcours(snapshot.data!.item2[i].parcoursid)), height: 172, width: 348,),
                              SizedBox(height: 7),
                              Text("Voir",style: TextStyle(fontSize: 20,color: Colors.white)),
                            ],
                          ),
                        ),
                        ),
                      },
                    ].toList(),
                  ),
                ),
              ),
              backgroundColor: Color(0xFF386E8F),
            );

          } else {
            return Center(
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
    );
  }
}