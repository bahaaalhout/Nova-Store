import 'package:flutter/material.dart';

class ShowSnackBar {
  snackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor: Colors.red.withOpacity(0.5),
      ),
    );
  }
}
