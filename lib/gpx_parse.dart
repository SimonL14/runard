import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xml/xml.dart' as xml;

Future<List<xml.XmlElement>> searchElements(String gpxContent) async {
  xml.XmlDocument document = xml.XmlDocument.parse(gpxContent);
  print(document.findAllElements('rtept').toList());
  return document.findAllElements('rtept').toList();
}

/*
class MyListView extends StatelessWidget {

  @override
  Future<Widget> build(BuildContext context) async {

    WidgetsFlutterBinding.ensureInitialized();
    String gpxContent = await rootBundle.loadString('assets/data/test.gpx');

    List<xml.XmlElement> rteptElements = await searchElements(gpxContent);

    final tiles = rteptElements.map((rtept) {
      final lat = rtept.getAttribute('lat');
      final lon = rtept.getAttribute('lon');
      return ListTile(
          title: Text('Latitude: $lat'),
          subtitle: Text('Longitude: $lon'),
      );
    }).toList();

    return ListView(
      children: tiles,
    );
  }
}
*/

void main() async {
  // Charge le contenu du fichier gpx à partir de son chemin d'accès
  WidgetsFlutterBinding.ensureInitialized();
  String gpxContent = await rootBundle.loadString('assets/data/test.gpx');

  // Recherche tous les éléments <rtept>
  List<xml.XmlElement> rteptElements = await searchElements(gpxContent);
  /*
    for (final rtept in rteptElements) {
      print('lat: ${rtept.getAttribute('lat')}');
      print('lon: ${rtept.getAttribute('lon')}');
    }
  */
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("GPX data"),
        ),
        body: ListView.builder(
          itemCount: rteptElements.length,
          itemBuilder: (context, index) {
            final rtept = rteptElements[index];
            return ListTile(
              title: Text(rtept.findElements('name').first.text),
              subtitle: Text("lat: ${rtept.getAttribute('lat')}\nlon: ${rtept.getAttribute('lon')}"),
            );
          },
        ),
      ),
    ),
  );
}
//This will display a ListView with each item containing the lat and lon attributes of the rtept element as the title and subtitle, respectively.
