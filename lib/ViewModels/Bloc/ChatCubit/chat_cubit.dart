import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Models/MessageModel/message_model.dart';

import '../../Constants/constants.dart';
import 'chat_states.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInit());

  static ChatCubit get(BuildContext context) => BlocProvider.of(context);

  ImagePicker picker = ImagePicker();
  File? chatImage;

  void openGallery() async {
    final chosenFile = await picker.pickImage(source: ImageSource.gallery);
    if (chosenFile != null) {
      chatImage = File(chosenFile.path);
      emit(GalleryFileSelected());
    }
  }

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future uploadPostImage(String receiverId) {
    return _firebaseStorage
        .ref()
        .child(
            "Chats/$uId+$receiverId/${Uri(path: chatImage!.path).pathSegments.last}")
        .putFile(chatImage!)
        .then((value) => value.ref.getDownloadURL());
  }

  Future addMessageToSender(MessageModel messageModel, String receiverId) {
    emit(MessageSendSuccess());
    return _firebaseFirestore
        .collection("Chats")
        .doc(uId! + receiverId)
        .collection("messages")
        .add(messageModel.toMap());
  }

  Future addMessageToReceiver(MessageModel messageModel, String receiverId) {
    return _firebaseFirestore
        .collection("Chats")
        .doc(receiverId + uId!)
        .collection("messages")
        .add(messageModel.toMap());
  }

  addMessageToFireBase({
    String? message,
    required String receiverId,
    required String dateTime,
    String? image,
  }) {
    MessageModel messageModel = MessageModel(
        message: message,
        dateTime: dateTime,
        senderId: uId!,
        receiverId: receiverId,
        image: image);
    addMessageToSender(messageModel, receiverId).then((value) {
      addMessageToReceiver(messageModel, receiverId).then((value) {
        emit(MessageSendSuccess());
      }).catchError((err) {
        emit(MessageSendError());
      });
    }).catchError((err) {
      emit(MessageSendError());
    });
  }

  void sendMessage({
    String? message,
    required String receiverId,
    required String dateTime,
  }) {
    emit(MessageSendSuccess());
    if (chatImage != null) {
      uploadPostImage(receiverId).then((value) {
        addMessageToFireBase(
            message: message,
            receiverId: receiverId,
            dateTime: dateTime,
            image: value);
      });
    } else {
      addMessageToFireBase(
          message: message, receiverId: receiverId, dateTime: dateTime);
    }
    chatImage = null;
  }

  List<MessageModel> messages = [];
  getMessages(String receiverId) {
    emit(GetChatLoading());
    _firebaseFirestore
        .collection("Chats")
        .doc(uId! + receiverId)
        .collection("messages")
        .orderBy("dateTime")
        .snapshots()
        .listen((event) {
      messages = [];
      for (var value in event.docs) {
        messages.add(MessageModel.fromJson(value.data()));
      }
      emit(GetChatSuccess());
    });
  }

  final TextEditingController messageController = TextEditingController();

  void changeMessageIcon() {
    emit(ChangeMessageIcon());
  }

  bool emojiHide = true;
  changeEmojiState(bool state) {
    emojiHide = state;
    emit(ChangeEmojiState());
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
}
