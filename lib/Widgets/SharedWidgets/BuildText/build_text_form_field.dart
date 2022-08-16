import 'package:flutter/material.dart';

class BuildTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final IconData? preFix;
  final IconData? postFix;
  final TextInputType? keyboard;
  final bool? obscureText;
  final String? placeholder;
  final String? Function(String?)? validate;

  const BuildTextFormField(
      {Key? key,
      @required this.controller,
      this.label,
      this.preFix,
      this.postFix,
      this.keyboard,
      this.obscureText,
      this.placeholder,
      this.validate})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          validator: validate,
          keyboardType: keyboard,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
              hintText: placeholder,
              label: Text(label!),
              prefixIcon: Icon(preFix),
              suffixIcon: Icon(postFix),
              border: const OutlineInputBorder(borderSide: BorderSide()),
              isDense: true),
        )
      ],
    );
  }
}
