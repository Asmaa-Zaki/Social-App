import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:social_app/ViewModels/Constants/constants.dart';

import '../../../ViewModels/Components/Components.dart';
import '../../SharedWidgets/ShowImage/show_image.dart';

class ReceiverMessage extends StatelessWidget {
  final String? messageTxt;
  final String messageTime;
  final String? messageImage;
  const ReceiverMessage(
      {Key? key, this.messageTxt, required this.messageTime, this.messageImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool rtl = intl.Bidi.detectRtlDirectionality(messageTxt ?? '');

    return Align(
        alignment: AlignmentDirectional.centerStart,
        child: IntrinsicWidth(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  flex: 3,
                  child: Container(
                      decoration: BoxDecoration(
                          color: secondDefaultColor.withOpacity(.1),
                          borderRadius: const BorderRadiusDirectional.only(
                            topStart: Radius.circular(10),
                            bottomEnd: Radius.circular(10),
                            topEnd: Radius.circular(10),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IntrinsicWidth(
                          child: Column(
                            children: [
                              if (messageImage != null)
                                InkWell(
                                  child:
                                      Image(image: NetworkImage(messageImage!)),
                                  onTap: () {
                                    buildPush(
                                        context, ShowImage(messageImage!));
                                  },
                                ),
                              if (messageTxt != null)
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    messageTxt!,
                                    textDirection: rtl
                                        ? TextDirection.rtl
                                        : TextDirection.ltr,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              Container(
                                padding: const EdgeInsets.only(top: 4),
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  messageTime,
                                  textDirection: rtl
                                      ? TextDirection.rtl
                                      : TextDirection.ltr,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .iconTheme
                                          .color
                                          ?.withOpacity(.4)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))),
              const Expanded(flex: 1, child: SizedBox()),
            ],
          ),
        ));
  }
}
