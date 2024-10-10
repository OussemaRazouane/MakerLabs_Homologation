import 'package:flutter/material.dart';
import 'package:makerlab/constants/constant.dart';

class CustomField extends StatefulWidget {
  final TextEditingController value;
  final GlobalKey<FormState> txtKey;
  final String name;
  final TextInputType type;
  final bool doIt; // true if you want to verify the input or false otherwise.

  final bool Function(dynamic) fn;

  const CustomField(
      {super.key,
      required this.txtKey,
      required this.value,
      required this.name, 
      required this.type, 
      required this.fn, 
      this.doIt=true});
  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.txtKey,
      child: TextFormField(
      controller: widget.value,
      keyboardType:widget.type,
      decoration: InputDecoration(
        labelText: widget.name,
        hintText: widget.name,
        focusColor:fieldColor,
        hoverColor: fieldColor,
        fillColor: fieldColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(fieldRadius),
        ),
      ),
      validator: (val) {
        if (val!.isEmpty) {
          return "The ${widget.name}  is required";
        } else if (!widget.fn(int.tryParse(val))&& widget.doIt) {
          return "Verify your ${widget.name} ";
        }
        return null;
      }),
    );
  }
}
