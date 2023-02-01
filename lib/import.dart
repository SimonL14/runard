import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
export 'import.dart';


  void openFiles() async {
    FilePickerResult? resultFile = await FilePicker.platform.pickFiles();
    if (resultFile != null) {
      PlatformFile? file = resultFile?.files.first;
      print(file?.name);
      print(file?.bytes);
      print(file?.extension);
      print(file?.path);
    } else {
      //do something here if the user canceled the picker
    }
  }


