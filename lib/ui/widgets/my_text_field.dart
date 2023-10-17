import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  String? hintText;
  TextEditingController textfieldController;
  MyTextField({super.key, this.hintText, required this.textfieldController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (event){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      controller: textfieldController,
      decoration: InputDecoration(
          hintText: hintText
      ),
    );
  }
}