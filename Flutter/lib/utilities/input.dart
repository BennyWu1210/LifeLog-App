import 'package:flutter/material.dart';
import 'package:journal_app/style/style.dart';

class InputField extends StatelessWidget {
  final String hint;
  final bool isPassword;

  const InputField({required this.hint, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: lightgreen,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class CoolButton extends StatelessWidget {
  final String text;
  final Function() handler;

  CoolButton({required this.text, required this.handler});
  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: handler,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      style: FilledButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        backgroundColor: medgreen, // set the button's size
      ),
    );
  }
}

Widget addButton(onPressed) {
  return FloatingActionButton(
      onPressed: onPressed,
      tooltip: 'Increment',
      backgroundColor: medgreen,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      heroTag: "navbarM",
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 35.0,
      ));
}
