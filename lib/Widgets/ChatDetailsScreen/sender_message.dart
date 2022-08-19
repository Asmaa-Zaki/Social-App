import 'package:flutter/material.dart';
import 'package:social_app/ViewModels/Components/components.dart';

import '../SharedWidgets/ShowImage/show_image.dart';

class SenderMessage extends StatelessWidget {
  final String? messageTxt;
  final String messageTime;
  final String? messageImage;
  const SenderMessage({
    Key? key,
    this.messageImage,
    this.messageTxt,
    required this.messageTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: AlignmentDirectional.centerEnd,
        child: IntrinsicWidth(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                flex: 3,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.shade900,
                        borderRadius: const BorderRadiusDirectional.only(
                          topStart: Radius.circular(10),
                          bottomStart: Radius.circular(10),
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
                                  buildPush(context, ShowImage(messageImage!));
                                },
                              ),
                            if (messageTxt != null)
                              Container(
                                padding: const EdgeInsets.only(top: 4),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  messageTxt!,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                            Container(
                              padding: const EdgeInsets.only(top: 4),
                              alignment: Alignment.bottomRight,
                              child: Text(
                                messageTime,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[350],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              )
            ],
          ),
        ));
  }
}
