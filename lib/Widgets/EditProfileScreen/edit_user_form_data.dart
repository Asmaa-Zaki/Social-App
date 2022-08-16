import 'package:flutter/material.dart';

import '../SharedWidgets/BuildText/build_text_form_field.dart';

class EditUserFormData extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController dioController;
  final TextEditingController phoneController;

  const EditUserFormData(
      this.nameController, this.dioController, this.phoneController,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        BuildTextFormField(
          controller: nameController,
          label: "Name",
          preFix: Icons.person,
        ),
        const SizedBox(
          height: 20,
        ),
        BuildTextFormField(
          controller: dioController,
          label: "Dio",
          preFix: Icons.info,
        ),
        const SizedBox(
          height: 20,
        ),
        BuildTextFormField(
          controller: phoneController,
          label: "Phone",
          preFix: Icons.phone,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
