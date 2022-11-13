///Dart import
import 'dart:io';

import 'package:open_file/open_file.dart';

///Package imports
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

// ignore: avoid_classes_with_only_static_members
///To save the pdf file in the device
class FileSaveHelper {
  ///To save the pdf file in the device
  static Future<String> saveAndLaunchFile(
      List<int> bytes, String fileName) async {
    String? path;
    if (Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isLinux ||
        Platform.isWindows) {
      final Directory directory = await getApplicationSupportDirectory();
      path = directory.path;
    } else {
      path = await PathProviderPlatform.instance.getApplicationSupportPath();
    }
    final File file =
        File(Platform.isWindows ? '$path\\$fileName' : '$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    if (Platform.isAndroid || Platform.isIOS) {
      try {
        await OpenFile.open('$path/$fileName');
        //File('$path/$fileName').delete();
        //ignore: unused_local_variable
        //final Future<Map<String, String>?> result =
        //   _platformCall.invokeMethod('viewPdf', argument);
      } catch (e) {
        // throw Exception(e);
      }
    } else if (Platform.isWindows) {
      await Process.run('start', <String>['$path\\$fileName'],
          runInShell: true);
    } else if (Platform.isMacOS) {
      await Process.run('open', <String>['$path/$fileName'], runInShell: true);
    } else if (Platform.isLinux) {
      await Process.run('xdg-open', <String>['$path/$fileName'],
          runInShell: true);
    }
    return "$path/$fileName";
  }
}
