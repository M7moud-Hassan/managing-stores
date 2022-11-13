import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class AppUtil {
  static Future<String> createFolderInAppDocDir(String folderName) async {
    //Get this App Document Directory
    final Directory? appDocDir = await getExternalStorageDirectory();
    //App Document Directory + folder name
    final Directory appDocDirFolder =
        Directory('${appDocDir!.path}/$folderName/');

    if (await appDocDirFolder.exists()) {
      //if folder already exists return path
      return appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      final Directory appDocDirNewFolder =
          await appDocDirFolder.create(recursive: true);
      return appDocDirNewFolder.path;
    }
  }

  static Future<String> getFont() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = '${dir.path}/Arial.ttf';
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data = await rootBundle.load("assets/fonts/Arial.ttf");

      List<int> bytes =
          data.buffer.asInt8List(data.offsetInBytes, data.lengthInBytes);

      await new File(path).writeAsBytes(bytes);
    }

    return path;
  }
}
