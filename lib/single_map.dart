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
        body: GPXMap(points: DbHelper.instance.getAllPointsParcoursfut(DbHelper.instance.getLastParcoursId()))
    );
  }
}