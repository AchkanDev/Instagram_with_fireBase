import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool obsureText;
  final TextInputType textInputType;

  const TextFieldInput(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      required this.obsureText,
      required this.textInputType});
  @override
  Widget build(BuildContext context) {
    final border =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: textEditingController,
      obscureText: obsureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: border,
        focusedBorder: border,
        enabledBorder: border,
        contentPadding: EdgeInsets.all(8),
        filled: true,
      ),
      keyboardType: textInputType,
    );
  }
}
