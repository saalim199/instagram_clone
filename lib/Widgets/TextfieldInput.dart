import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textcontroller;
  final String hinttext;
  final TextInputType keyboardtype;
  final bool isPass;

  const TextFieldInput({
    Key? key,
    required this.textcontroller,
    required this.hinttext,
    required this.keyboardtype,
    this.isPass = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textcontroller,
      decoration: InputDecoration(
        hintText: hinttext,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
      keyboardType: keyboardtype,
      obscureText: isPass,
    );
  }
}
