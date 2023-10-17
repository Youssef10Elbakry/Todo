import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  String? hintText;
  String intitalizingText;
  TextEditingController textfieldController;
  bool isFirstTime = true;
  MyTextField({super.key, this.hintText, required this.textfieldController, required this.intitalizingText});
  @override

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