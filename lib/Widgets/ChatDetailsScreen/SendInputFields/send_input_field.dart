import 'package:flutter/material.dart';

import 'message_text_field.dart';
import 'send_image.dart';

class SendInputField extends StatelessWidget {
  final bool image;

  const SendInputField({Key? key, required this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
            color: Colors.blueGrey[900],
            borderRadius:
                const BorderRadiusDirectional.all(Radius.circular(20))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const MessageTextField(),
            if (image != true) const SendImage()
          ],
        ),
      ),
    );
  }
}
