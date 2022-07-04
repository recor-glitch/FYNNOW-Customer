import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomAddressField extends StatefulWidget {
  const CustomAddressField({Key? key, required this.label, required this.controller})
      : super(key: key);
  final String label;
  final TextEditingController controller;

  @override
  State<CustomAddressField> createState() => _CustomAddressFieldState();
}

class _CustomAddressFieldState extends State<CustomAddressField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
          label: Text(widget.label),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}
