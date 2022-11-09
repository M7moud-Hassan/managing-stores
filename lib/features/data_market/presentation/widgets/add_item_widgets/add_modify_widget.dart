import 'package:flutter/material.dart';
import 'package:mustafa/core/strings/home_str.dart';

const PADDING = 8.0;

class AddOrModfiyWidget extends StatelessWidget {
  AddOrModfiyWidget({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(PADDING),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              _textFormField(),
              _textFormField(),
              _textFormField(),
              _textFormField(),
              _saveChanges(),
            ],
          )),
    );
  }

  TextFormField _textFormField() => TextFormField();
  ElevatedButton _saveChanges() =>
      ElevatedButton(onPressed: () {}, child: const Text(SAVE));
}
