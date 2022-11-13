import 'package:flutter/material.dart';
import 'package:mustafa/core/strings/hello_page_str.dart';

const MARGIN_LOGO = 20.0;
const PATH_LOGO = "assets/logo/logo.png";

class HelloPage extends StatelessWidget {
  const HelloPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: MARGIN_LOGO),
              child: Image.asset(
                PATH_LOGO,
              ),
            ),
            Text(
              HELLO,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              DESCRIBTION_HELLO,
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
