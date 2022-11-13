import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:mustafa/core/widgets/loading_widget.dart';

AwesomeDialog loadExportWidget(BuildContext context) => AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.noHeader,
      body: const LoadingWidget(),
      autoDismiss: false,
      onDismissCallback: (type) {},
    );
