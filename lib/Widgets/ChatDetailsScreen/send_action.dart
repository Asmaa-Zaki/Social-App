import 'package:flutter/material.dart';

import '../../Models/UserModel/user_model.dart';
import 'SendInputFields/VoiceAndSendButton.dart';
import 'SendInputFields/send_input_field.dart';

class SendAction extends StatelessWidget {
  final UserModel receiver;
  final bool image;

  const SendAction(this.receiver, this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SendInputField(
          image: image,
        ),
        const SizedBox(
          width: 7,
        ),
        VoiceAndSendButton(
          receiver: receiver,
          image: image,
        )
      ],
    );
  }
}
