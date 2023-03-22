import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:latlong2/latlong.dart';

import 'package:runard/parcours_dto.dart';
import 'package:runard/points_dto.dart';
import 'package:xml/xml.dart' as xml;
import 'dbhelper.dart';
import 'gpx_parse.dart';


  void openFiles() async {
    FilePickerResult? resultFile = await FilePicker.platform.pickFiles();
    if (resultFile != null) {

      int _calculateTotalTime(PointsDTO lastpoint, PointsDTO firstpoint) {
        int totalTime = 0;
          var timeFirstPoint = DateTime.parse(firstpoint.time!);
          var timeLastPoint = DateTime.parse(lastpoint.time!);
          var time = timeLastPoint.difference(timeFirstPoint);
          totalTime += time.inSeconds;
        return totalTime;
      }

      double _calculateTotalDistance(List<xml.XmlElement> rteptElementstrkpt) {
        double totalDistance = 0;
        for (int i = 0; i < rteptElementstrkpt.length - 1; i++) {
          LatLng pointLatLng = LatLng(
              double.parse(rteptElementstrkpt[i].getAttribute('lat')!),
              double.parse(rteptElementstrkpt[i].getAttribute('lon')!)
          );
          LatLng pointLatLngafter = LatLng(
              double.parse(rteptElementstrkpt[i+1].getAttribute('lat')!),
              double.parse(rteptElementstrkpt[i+1].getAttribute('lon')!)
          );
          totalDistance += Distance().distance(
            pointLatLng,
            pointLatLngafter,
          );
        }
        return totalDistance / 1000; // convert meters to kilometers
      }

      PlatformFile? file = resultFile?.files.first;

      String gpxContent = await File(file!.path!).readAsString();
      print('path : ${file?.path}');

      List<xml.XmlElement> rteptElementstrkpt = await searchElementstrkpt(
          gpxContent);
      List<xml.XmlElement> rteptElementstrk = await searchElementstrk(
          gpxContent);
      print(rteptElementstrk);

      int countrteptcalc = 0;
      PointsDTO? firstpoint = null;
      PointsDTO? lastpoint = null;
      String? temps = "";
      String? km = "";
      String? vitesse = "";
      for (final rtept in rteptElementstrkpt) {
        countrteptcalc = countrteptcalc + 1;
        if (countrteptcalc == 1){
          String? lat = rtept.getAttribute('lat');
          String? lon = rtept.getAttribute('lon');
          String time = rtept.getElement('time')!.text;
          String ele = rtept.getElement('ele')!.text;
          int parcoursId = 1;
          firstpoint = PointsDTO(null, lat, lon, ele, time, parcoursId);
        }
        if (countrteptcalc == rteptElementstrkpt.length){
          String? lat = rtept.getAttribute('lat');
          String? lon = rtept.getAttribute('lon');
          String time = rtept.getElement('time')!.text;
          String ele = rtept.getElement('ele')!.text;
          int parcoursId = 1;
          lastpoint = PointsDTO(null, lat, lon, ele, time, parcoursId);
        }
      }
      if (firstpoint != null && lastpoint != null) {
        int totalTime = _calculateTotalTime(lastpoint, firstpoint);
        int totalTimeSeconde = totalTime%60;
        int totalTimeMinute = (totalTime/60%60).round();
        int totalTimeHeure = (totalTime/60/60).toInt();
        temps = "$totalTimeHeure h $totalTimeMinute min $totalTimeSeconde s";
        double totalDistance = _calculateTotalDistance(rteptElementstrkpt);
        km = "$totalDistance";
        double totalVitesse = _calculateTotalDistance(rteptElementstrkpt)*1000/_calculateTotalTime(lastpoint, firstpoint);
        vitesse = "$totalVitesse m/s";
      }

      for (final trk in rteptElementstrk) {
        String? name = trk
            .getElement('name')
            ?.text;

        String? date = trk
            .getElement('time')
            ?.text;

        final ParcoursDTO parcours = ParcoursDTO(null, name, date, temps, km, vitesse);
        print(parcours.temps);
        DbHelper.instance.insertParcours(parcours);

        print('insert parcours ok');
      }


      int parcoursId = await DbHelper.instance.getLastParcoursId() as int;


      int countrtept = 0;
      for (final rtept in rteptElementstrkpt) {
        countrtept = countrtept + 1;
        if (countrtept % 3 == 0 || countrtept == 1 ||
            countrtept == rteptElementstrkpt.length) {
          String? lat = rtept.getAttribute('lat');
          String? lon = rtept.getAttribute('lon');
          String time = rtept.getElement('time')!.text;
          String ele = rtept.getElement('ele')!.text;
          final PointsDTO points = PointsDTO(
              null, lat, lon, ele, time, parcoursId);
          await DbHelper.instance.insertPoints(points);


        }
      }
    }

  }



