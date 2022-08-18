import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Models/PostModel/post_model.dart';
import '../../Constants/constants.dart';
import 'post_states.dart';

class PostCubit extends Cubit<PostAppStates> {
  PostCubit() : super(PostAppInitState());

  static PostCubit get(context) => BlocProvider.of(context);

  //post
  ImagePicker picker = ImagePicker();
  File? postImage;
  void getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostGetImageState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(PostDeleteImageState());
  }

  void createPostWithImage({
    @required String? text,
    @required String? dateTime,
    required BuildContext context
  }) {
    emit(PostUploadImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child("Posts/$uId/${Uri(path: postImage!.path).pathSegments.last}")
        .putFile(postImage!)
        .then((value) {
      emit(PostUploadImageSuccessState());
      value.ref.getDownloadURL().then((value) {
        emit(PostUploadImageSuccessState());
        createPost(text: text, dateTime: dateTime, postImage: value, context: context);
      }).catchError((err) {
        emit(PostUploadImageErrorState());
      });
    }).catchError((err) {
      emit(PostUploadImageErrorState());
    });
  }

  void createPost(
      {@required String? text, @required String? dateTime, String? postImage, @required context}) {
    emit(PostCreateLoadingState());
    PostModel post = PostModel(
        uId: uId,
        text: text,
        dateTime: dateTime,
        postImage: postImage);
    FirebaseFirestore.instance
        .collection("Posts")
        .add(post.toMap())
        .then((value) {
      emit(PostCreateSuccessState());
      removePostImage();
      getPosts();
    }).catchError((err) {
      emit(PostCreateErrorState());
    });
  }

  List<PostModel> postsList = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts() {
    postsList = [];
    postsId = [];
    likes = [];
    emit(PostsGetLoadingState());
    FirebaseFirestore.instance.collection("Posts").orderBy("dateTime").get().then((value) {
      for (var element in value.docs) {
        postsList.add(PostModel.fromJson(element.data()));
        element.reference.collection("Likes").get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          emit(PostsGetSuccessState());
        });
      }
    }).catchError((err) {
      emit(PostsGetErrorState());
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection("Posts")
        .doc(postId)
        .collection("Likes")
        .doc(uId)
        .set({"Like": true}).then((value) {
      emit(PostLikeSuccessState());
      getPosts();
    }).catchError((err) {
      emit(PostLikeErrorState());
    });
  }
}
