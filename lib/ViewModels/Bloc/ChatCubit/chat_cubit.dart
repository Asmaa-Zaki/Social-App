import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Models/MessageModel/message_model.dart';

import '../../Constants/constants.dart';
import 'chat_states.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInit());

  static ChatCubit get(BuildContext context) => BlocProvider.of(context);

  void sendMessage(
      {required String message,
      required String receiverId,
      required String dateTime}) {
    MessageModel messageModel = MessageModel(
        message: message,
        dateTime: dateTime,
        senderId: uId!,
        receiverId: receiverId);
    FirebaseFirestore.instance
        .collection("Chats")
        .doc(uId)
        .collection("messages")
        .add(messageModel.toMap())
        .then((value) {
      FirebaseFirestore.instance
          .collection("Chats")
          .doc(receiverId)
          .collection("messages")
          .add(messageModel.toMap())
          .then((value) {
        emit(MessageSendSuccess());
      }).catchError((err) {
        emit(MessageSendError());
      });
    }).catchError((err) {
      emit(MessageSendError());
    });
  }

  List<MessageModel> messages = [];
  getMessages(String receiverId) {
    emit(GetChatLoading());
    FirebaseFirestore.instance
        .collection("Chats")
        .doc(uId)
        .collection("messages")
        .orderBy("dateTime")
        .snapshots()
        .listen((event) {
      emit(GetChatSuccess());
      messages = [];
      for (var value in event.docs) {
        if ((value.data()["receiverId"] == receiverId ||
                value.data()["receiverId"] == uId) &&
            ((value.data()["senderId"] == receiverId ||
                value.data()["senderId"] == uId))) {
          messages.add(MessageModel.fromJson(value.data()));
        }
      }
    });
  }
}
