import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
export 'import.dart';
import 'package:io/io.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


  void openFiles() async {
    FilePickerResult? resultFile = await FilePicker.platform.pickFiles();
    if (resultFile != null) {
      PlatformFile? file = resultFile?.files.first;
      print(file?.name);
      print(file?.bytes);
      print(file?.extension);
      print(file?.path);
      } else {
        print("Ce n'est pas un fichier gpx.");
      }
  }




