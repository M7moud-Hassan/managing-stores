import 'package:flutter/material.dart';
import 'package:mustafa/core/themes/app_theme.dart';

const double WID_HIGH = 30;

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: SizedBox(
          height: WID_HIGH,
          width: WID_HIGH,
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
