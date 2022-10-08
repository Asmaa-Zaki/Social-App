import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Models/MessageModel/message_model.dart';
import 'package:social_app/Models/UserModel/user_model.dart';
import 'package:social_app/ViewModels/Components/components.dart';

import '../../Constants/constants.dart';
import '../UserCubit/user_cubit.dart';
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

  late UserModel receiverUser;
  addMessageToFireBase({
    String? message,
    required String receiverId,
    required String dateTime,
    required BuildContext context,
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
        sendNotification(
            context: context,
            body: image == null ? message! : "new image",
            title: receiverUser.name,
            userId: receiverId,
            screen: 'chatsScreen',
            friendId: uId);
        if (image != null) {
          Navigator.pop(context);
        }
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
    required BuildContext context,
  }) {
    emit(MessageSendingLoading());
    UserCubit.get(context).getActiveDevices(receiverId);
    if (chatImage != null) {
      uploadPostImage(receiverId).then((value) {
        addMessageToFireBase(
            message: message,
            receiverId: receiverId,
            dateTime: dateTime,
            image: value,
            context: context);
      });
    } else {
      addMessageToFireBase(
          message: message,
          receiverId: receiverId,
          dateTime: dateTime,
          context: context);
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
