import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';

class PrimaryButton extends StatelessWidget {//neeed to write the test for it
  final String label;
  final VoidCallback onPressed;

  const PrimaryButton(
      {super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: cinemaBrand, foregroundColor: cinemaFontWhite),
            onPressed: onPressed,
            child: Text(label),
    );
  }
}
