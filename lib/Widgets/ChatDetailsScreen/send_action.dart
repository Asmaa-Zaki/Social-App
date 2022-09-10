import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/UserModel/user_model.dart';
import '../SharedWidgets/MessagesAndCommentsInput/send_input_field.dart';
import 'SendInputFields/voice_and_send_button.dart';

class SendAction extends StatelessWidget {
  final UserModel receiver;
  final bool image;

  const SendAction(this.receiver, this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SendInputField(
          hideImage: image,
          hideEmoji: false,
          message: true,
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
