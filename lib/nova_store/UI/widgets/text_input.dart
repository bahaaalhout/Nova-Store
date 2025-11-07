import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.controller,
    required this.hintText,

    required this.isPass,
    required this.validate,
  });
  final TextEditingController controller;
  final String hintText;

  final bool isPass;
  final String? Function(String?)? validate;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),

      child: TextFormField(
        validator: validate,
        controller: controller,

        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.only(left: 20),
        ),
        obscureText: isPass,
      ),
    );
  }
}
