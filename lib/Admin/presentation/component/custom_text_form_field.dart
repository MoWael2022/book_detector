import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({super.key,required this.name,required this.textEditingController});
  String name;
  TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration:InputDecoration(
        hintText: name,
        border:const OutlineInputBorder()

      ),
    );
  }
}
