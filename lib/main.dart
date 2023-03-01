import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:runard/splash.dart';

import 'firebase_options.dart';

void main() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Runard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
    );
  }
}


/*const assetImage = AssetImage('assets/logo.png');
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
}*/
