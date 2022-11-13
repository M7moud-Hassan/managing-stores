import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../strings/home_str.dart';
import '../widgets/bill_holder_add_widget.dart';

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

  static bool checkInvoiceExits(String path) {
    return FileSystemEntity.typeSync(path) != FileSystemEntityType.notFound;
  }

  static Directory? dir;
  static Future<String> getPath() async {
    dir = await getApplicationDocumentsDirectory();
    return dir!.path;
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

  static void showSheetAddBillHolder(context) {
    BillAdd billAdd = BillAdd();
    AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.noHeader,
            body: billAdd,
            autoDismiss: false,
            onDismissCallback: (type) {},
            btnOkOnPress: () {
              billAdd.openInvoice(context);
            },
            btnOkText: SAVE,
            btnCancelOnPress: () {
              Navigator.pop(context);
            },
            btnCancelText: CANCEL)
        .show()
        .whenComplete(() => null);
  }
}
