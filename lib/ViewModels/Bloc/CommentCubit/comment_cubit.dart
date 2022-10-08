import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Models/PostModel/post_model.dart';
import 'package:social_app/ViewModels/Bloc/CommentCubit/comment_states.dart';
import 'package:social_app/ViewModels/Components/components.dart';

import '../../../Models/CommentModel/comment_model.dart';
import '../../Constants/constants.dart';
import '../UserCubit/user_cubit.dart';

class CommentCubit extends Cubit<CommentStates> {
  CommentCubit() : super(CommentInitState());

  static CommentCubit get(BuildContext context) => BlocProvider.of(context);

  ImagePicker picker = ImagePicker();
  File? commentImagePath;
  File? commentImageName;

  void openGallery() async {
    final chosenFile = await picker.pickImage(source: ImageSource.gallery);
    if (chosenFile != null) {
      commentImagePath = File(chosenFile.path);
      commentImageName = File(chosenFile.name);
      emit(GalleryFileSelected());
    }
  }

  void showSelectedImage() {
    emit(GalleryImageShown());
  }

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future addCommentWithImage({required BuildContext context}) {
    String comment = commentController.text;
    commentController.clear();
    return _firebaseStorage
        .ref()
        .child("Comments/${currentPost.postId}/$commentImageName")
        .putFile(commentImagePath!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        addComment(image: value, comment: comment, context: context);
      });
    });
  }

  final TextEditingController commentController = TextEditingController();

  void addComment(
      {String? image, required String comment, required BuildContext context}) {
    commentController.clear();
    UserCubit.get(context).getActiveDevices(currentPost.uId);
    CommentModel _commentModel = CommentModel(
        comment: comment.isEmpty ? null : comment,
        dateTime: DateTime.now().toString(),
        postId: currentPost.postId,
        commentOwner: uId!,
        image: image);
    _firebaseFirestore
        .collection("Comments")
        .doc(currentPost.postId)
        .collection("Comments")
        .add(_commentModel.toMap())
        .then((value) {
      if (uId != currentPost.uId) {
        sendNotification(
            context: context,
            body: "${UserCubit.get(context).user!.name} comments on your post",
            title: "Post Updates",
            userId: currentPost.uId,
            postId: currentPost.postId,
            screen: 'postScreen');
        addNotificationToFirebase(
            currentPost.uId, "comments on your post", uId!);
      }
      if (image != null) {
        CommentCubit.get(context).commentImagePath = null;
        Navigator.pop(context);
      }
    });
  }

  void postComment(BuildContext context) {
    emit(SendCommentLoading());
    if (commentImagePath != null) {
      addCommentWithImage(context: context);
    } else {
      addComment(comment: commentController.text, context: context);
    }
  }

  List<CommentModel> comments = [];
  void getComments({required String postId}) {
    comments = [];
    _firebaseFirestore
        .collection("Comments")
        .doc(postId)
        .collection("Comments")
        .orderBy("dateTime")
        .snapshots()
        .listen((event) {
      comments = [];
      for (var element in event.docs) {
        comments.add(CommentModel.fromJson(element.data()));
      }
      emit(GetCommentsSuccess());
    });
  }

  bool emojiHide = true;
  changeEmojiState(bool state) {
    emojiHide = state;
    emit(ChangeEmojiState());
  }

  void changeMessageIcon() {
    emit(ChangeMessageIcon());
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late PostModel currentPost;

  bool keyboardFocus = false;
  changeKeyboardState(bool state) {
    keyboardFocus = state;
    emit(ChangeKeyboardState());
  }
}
