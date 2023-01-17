import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:xml/xml.dart' as xml;

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
  }

  Future<void> _loadGPXData() async {
    String gpxContent = await rootBundle.loadString('assets/data/test2.gpx');
    var document = xml.XmlDocument.parse(gpxContent);

    for (var trkpt in document.findAllElements('trkpt')) {
      double lat, lon;
      try {
        lat = double.parse(trkpt.attributes.firstWhere((node) => node.name.local == 'lat').value);
        lon = double.parse(trkpt.attributes.firstWhere((node) => node.name.local == 'lon').value);

      } on FormatException catch (e) {
        print("An error occured while parsing latitude and longitude: $e");
        continue;
      }
      _polylinePoints.add(LatLng(lat, lon));
      var marker = Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(lat, lon),
        builder: (ctx) => Container(
          child: Icon(Icons.flag_circle, color: Colors.red, size: 10),
        ),
      );
      _markers.add(marker);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center:  _polylinePoints[1],
        zoom: 13.0,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        MarkerLayer(markers: _markers),
        PolylineLayer(
          polylines: [
            Polyline(
              points: _polylinePoints,
              strokeWidth: 4.0,
              color: Colors.blue,
            ),
          ],
        ),
      ],
    );
  }
}







