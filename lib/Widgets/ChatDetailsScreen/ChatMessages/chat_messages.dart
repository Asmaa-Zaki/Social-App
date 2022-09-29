import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_cubit.dart';
import 'package:social_app/ViewModels/Constants/constants.dart';

import '../../../Models/MessageModel/message_model.dart';
import '../../../Models/UserModel/user_model.dart';
import 'receiver_message.dart';
import 'sender_message.dart';

class MessagesList extends StatelessWidget {
  final UserModel receiver;
  final List<MessageModel> messages;
  const MessagesList(this.receiver, this.messages, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ConditionalBuilder(
      condition: messages.isNotEmpty,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: GroupedListView<dynamic, String>(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              elements: messages,
              groupBy: (element) => element.dateTime.split(" ")[0],
              groupSeparatorBuilder: (String groupByValue) => Align(
                    alignment: Alignment.topCenter,
                    child: IntrinsicWidth(
                      child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5)),
                          padding: const EdgeInsets.all(7),
                          child: Text(
                            dateFormat.format(DateTime.parse(groupByValue)),
                            style: const TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
              itemBuilder: (context, dynamic element) {
                if (element.senderId == UserCubit.get(context).user?.uId) {
                  return SenderMessage(
                      messageTxt: element.message,
                      messageTime:
                          timeFormat.format(DateTime.parse(element.dateTime)),
                      messageImage: element.image);
                } else {
                  return ReceiverMessage(
                      messageTxt: element.message,
                      messageTime:
                          timeFormat.format(DateTime.parse(element.dateTime)),
                      messageImage: element.image);
                }
              },
              separator: Container(
                height: 10,
              ),
              useStickyGroupSeparators: true,
              floatingHeader: true,
              reverse: true,
              itemComparator: (item1, item2) =>
                  item1.dateTime.compareTo(item2.dateTime),
              order: GroupedListOrder.DESC),
        );
      },
      fallback: (context) {
        return const Center(
          child: Text("Start Chat"),
        );
      },
    ));
  }
}
