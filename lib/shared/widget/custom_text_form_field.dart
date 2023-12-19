import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String title;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  const CustomTextFormField(
      {super.key, required this.title, this.keyboardType, this.controller});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType ?? TextInputType.text,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.title,
        labelStyle: const TextStyle(color: Colors.green),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
