import 'dart:io';
import 'package:file_picker/file_picker.dart';

import 'package:runard/parcours_dto.dart';
import 'package:runard/points_dto.dart';
import 'package:xml/xml.dart' as xml;
import 'dbhelper.dart';
import 'gpx_parse.dart';


  void openFiles() async {
    FilePickerResult? resultFile = await FilePicker.platform.pickFiles();
    if (resultFile != null) {
      PlatformFile? file = resultFile?.files.first;

      String gpxContent = await File(file!.path!).readAsString();
      print('path : ${file?.path}');

      List<xml.XmlElement> rteptElementstrkpt = await searchElementstrkpt(
          gpxContent);
      List<xml.XmlElement> rteptElementstrk = await searchElementstrk(
          gpxContent);
      print(rteptElementstrk);
      for (final trk in rteptElementstrk) {
        String? name = trk
            .getElement('name')
            ?.text;

        String? date = trk
            .getElement('time')
            ?.text;

        final ParcoursDTO parcours = ParcoursDTO(null, name, date);
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



