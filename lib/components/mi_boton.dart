import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function()? onTap;

  const MyButton({Key? key, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.symmetric(horizontal: 130.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 52, 105, 179),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Color.fromARGB(255, 249, 249, 249),
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}