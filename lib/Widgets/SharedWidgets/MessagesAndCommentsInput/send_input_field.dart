import 'package:flutter/material.dart';
import 'package:social_app/ViewModels/Constants/constants.dart';

import '../../ChatDetailsScreen/SendInputFields/send_image.dart';
import '../../CommentScreen/add_image.dart';
import 'message_comment_text_field.dart';
import 'send_emoji.dart';

class SendInputField extends StatelessWidget {
  final bool hideImage;
  final bool message;
  final bool hideEmoji;

  const SendInputField(
      {Key? key,
      required this.hideImage,
      required this.message,
      required this.hideEmoji})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 10,
      child: Container(
        margin: const EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
            color: firstDefaultColor,
            borderRadius:
                const BorderRadiusDirectional.all(Radius.circular(20))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (hideEmoji == false)
              SendEmoji(
                message: message,
              ),
            if (hideEmoji == true)
              const SizedBox(
                width: 15,
              ),
            MessageAndCommentTextField(message: message),
            if (hideImage != true && message == true) const SendImage(),
            if (hideImage != true && message == false) const AddImage()
          ],
        ),
      ),
    );
  }
}
