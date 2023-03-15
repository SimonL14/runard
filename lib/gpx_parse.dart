import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:runard/parcours_dto.dart';
import 'package:runard/points_dto.dart';
import 'package:xml/xml.dart' as xml;
import 'package:tuple/tuple.dart';

import 'dbhelper.dart';
import 'import.dart';

Future<List<xml.XmlElement>> searchElementstrkpt(String gpxContent) async {
  xml.XmlDocument document = xml.XmlDocument.parse(gpxContent);
  return document.findAllElements('trkpt').toList();
}
Future<List<xml.XmlElement>> searchElementstrk(String gpxContent) async {
  xml.XmlDocument document = xml.XmlDocument.parse(gpxContent);
  return document.findAllElements('trk').toList();
}

class GPXMap extends StatefulWidget {
  @override
  _GPXMapState createState() => _GPXMapState();
}

class _GPXMapState extends State<GPXMap> {

  List<Marker> _markers = [];
  List<LatLng> _polylinePoints = [];
  @override
  void initState() {
    super.initState();
    _loadGPXData();
    _ImportGPX();
  }


  Future<void> _loadGPXData() async {
    String gpxContent = await rootBundle.loadString('assets/data/test2.gpx');
    var document = xml.XmlDocument.parse(gpxContent);

    LatLngBounds bounds = LatLngBounds.fromPoints(_polylinePoints);

   /* int _calculateTotalTime() {
      int totalTime = 0;
      for (int i = 0; i < _polylinePoints.length - 1; i++) {
        var timeAtCurrentPoint = DateTime.parse(document.findAllElements('time').elementAt(i).text);
        var timeAtNextPoint = DateTime.parse(document.findAllElements('time').elementAt(i+1).text);
        var difference = timeAtNextPoint.difference(timeAtCurrentPoint);
        totalTime += difference.inSeconds;
      }
      return totalTime;
    }*/

    for (var trkpt in document.findAllElements('trkpt')) {
      double lat, lon;
      try {
        lat = double.parse(trkpt.attributes
            .firstWhere((node) => node.name.local == 'lat')
            .value);
        lon = double.parse(trkpt.attributes
            .firstWhere((node) => node.name.local == 'lon')
            .value);
      } on FormatException catch (e) {
        print("An error occured while parsing latitude and longitude: $e");
        continue;
      }
      _polylinePoints.add(LatLng(lat, lon));
    }

    /*
    int totalTime = _calculateTotalTime();
    int totalTimeSeconde = totalTime%60;
    int totalTimeMinute = (totalTime/60%60).round();
    int totalTimeHeure = (totalTime/60/60).toInt();

    print("Total temps : $totalTimeHeure h $totalTimeMinute min $totalTimeSeconde s");
    double totalDistance = _calculateTotalDistance();
    print("Total distance : $totalDistance km");
    double totalVitesse = _calculateTotalDistance()*1000/_calculateTotalTime();
    print("Total vitesse : $totalVitesse m/s");
*/

    var markerfin = Marker(
      width: 30.0,
      height: 30.0,
      point: _polylinePoints[_polylinePoints.length - 1],
      builder: (ctx) => Container(
        child: Image.asset("assets/flag.png",),
      ),
    );
    _markers.add(markerfin);

      var markerdebut =  Marker(
        width: 80.0,
        height: 80.0,
        point: _polylinePoints.first,
        builder: (ctx) => Container(
          child: Icon(Icons.flag, color: Color(0xFF112349), size: 30),
        ),
      );
      _markers.add(markerdebut);
    setState(() {
      // Adapter la vue à la position des points
      bounds = LatLngBounds.fromPoints(_polylinePoints);
    });
  }

  Future<void> _ImportGPX() async {
    WidgetsFlutterBinding.ensureInitialized();
    String gpxContent = await rootBundle.loadString('assets/data/test2.gpx');

    List<xml.XmlElement> rteptElementstrkpt = await searchElementstrkpt(gpxContent);
    List<xml.XmlElement> rteptElementstrk = await searchElementstrk(gpxContent);
      print(rteptElementstrk);
      for (final trk in rteptElementstrk) {
        String? name = trk.getElement('name')?.text;
        print(name);

        String? date = trk.getElement('time')?.text;
        print(date);

        final ParcoursDTO parcours = ParcoursDTO(null,name,date);
        // DbHelper.instance.insertParcours(parcours);

        // print('${trk.getElement('name')?.text}');
        // print('${trk.getElement('time')?.text}');


      }

    int parcoursId = await DbHelper.instance.getLastParcoursId() as int;


    int countrtept = 0;
    for (final rtept in rteptElementstrkpt) {
      countrtept = countrtept + 1;
      if (countrtept % 3 == 0 || countrtept == 1 || countrtept == rteptElementstrkpt.length) {
        String? lat = rtept.getAttribute('lat');
        String? lon = rtept.getAttribute('lon');
        String time = rtept.getElement('time')!.text;
        String ele = rtept.getElement('ele')!.text;
        final PointsDTO points = PointsDTO(
            null, lat, lon, ele, time, parcoursId);
        // await DbHelper.instance.insertPoints(points);

         //print('lat: ${rtept.getAttribute('lat')}');
         //print('lon: ${rtept.getAttribute('lon')}');
         //print('time: ${rtept.getElement('time')?.text}');
         //print('ele: ${rtept.getElement('ele')?.text}');


      }
    }

    //Obtenir le dernier parcours ( à afficher sur la page d'accueil)
    final lastparcours = await DbHelper.instance.getLatestParcours(parcoursId);
    final lastparcours1 = await lastparcours.item1;
    final lastparcours2 = await lastparcours.item2;

    print('last parcours: $lastparcours');
    print('last 1 : $lastparcours1');
    print('last 2 : $lastparcours2');
    final parcoursget = await DbHelper.instance.getAllParcours();
    final parcoursgetpoints = await parcoursget.item1;
    final parcoursgetparcour = await parcoursget.item2;

    print(parcoursgetparcour);
  }

  double _calculateTotalDistance() {
    double totalDistance = 0;
    for (int i = 0; i < _polylinePoints.length - 1; i++) {
      totalDistance += Distance().distance(
        _polylinePoints[i],
        _polylinePoints[i + 1],
      );
    }
    return totalDistance / 1000; // convert meters to kilometers
  }





  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        bounds: LatLngBounds.fromPoints(_polylinePoints),
        boundsOptions: FitBoundsOptions(
          padding: EdgeInsets.all(20.0),
        ),
        interactiveFlags: InteractiveFlag.none,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),


        MarkerLayer(markers: _markers

        ),
        PolylineLayer(
          polylines: [
            Polyline(
              points: _polylinePoints,
              strokeWidth: 4.0,
              color:Color(0xFF0394DE),
            ),
          ],
        ),
      ],
    );
  }
}







