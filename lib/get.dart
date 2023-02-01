import 'dart:io';
import 'package:path_provider/path_provider.dart';
export 'package:runard/get.dart';

Future<File> getFile(String fileName) async {
  final Directory appDirectory = await getApplicationDocumentsDirectory();
  final File file = File('${appDirectory.path}/$fileName');
  return file;
}