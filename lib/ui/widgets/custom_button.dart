import 'package:flutter/material.dart';

Widget customButton({required VoidCallback onPressed, required String title}) {
  return Center(
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(170, 50),
          primary: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        onPressed: () {
          onPressed();
        },
        child: Text(title ,style: const TextStyle(
          fontSize: 16
        ),)),
  );
}
