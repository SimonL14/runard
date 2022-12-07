import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

const assetImage = AssetImage('assets/logo.png');
const image = Image(image: assetImage);
void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override


  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var marker = <Marker>[];
    marker = [
      Marker(
        point: LatLng(50.95129, 1.858686),
        width: 80,
        height: 80,
        builder: (context) => Icon(Icons.pin_drop, color: Colors.green,),
      ),
      Marker(
        point: LatLng(50.95075711968188, 1.883327308080843),
        width: 80,
        height: 80,
        builder: (context) => Icon(Icons.pin_drop, color: Colors.blue,),
      ),
      Marker(
        point: LatLng(50.934850380699906, 1.8083729806019977),
        width: 80,
        height: 80,
        builder: (context) => Icon(Icons.pin_drop, color: Colors.red,),
      ),
    ];
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              Flexible(
                child: FlutterMap(
                  options:
                    MapOptions(center: LatLng(50.95129, 1.858686), zoom: 12),
                  children: [
                    TileLayer(
                      urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    ),
                    MarkerLayer(
                      markers: marker,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
