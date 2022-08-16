import 'package:flutter/material.dart';

class DarkThemeAction extends StatelessWidget {
  const DarkThemeAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          const Icon(Icons.light_mode),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "Dark Theme",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          const Spacer(),
          Switch(value: true, onChanged: (value) {}),
        ],
      ),
    );
  }
}
