import 'package:flutter/material.dart';

import '../SharedWidgets/MessagesAndCommentsInput/send_input_field.dart';
import 'add_comment_button.dart';

class SendComment extends StatelessWidget {
  final bool hideImage;
  final bool hideEmoji;
  const SendComment({
    Key? key,
    required this.hideImage,
    required this.hideEmoji,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        children: [
          SendInputField(
            hideImage: hideImage,
            hideEmoji: hideEmoji,
            message: false,
          ),
          const SizedBox(
            width: 5,
          ),
          const AddCommentButton()
        ],
      ),
    );
  }
}
