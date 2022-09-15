import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';

import '../../../Models/PostModel/post_model.dart';
import '../../Constants/constants.dart';
import 'post_states.dart';

class PostCubit extends Cubit<PostStates> {
  PostCubit() : super(PostAppInitState());

  static PostCubit get(context) => BlocProvider.of(context);

  ImagePicker picker = ImagePicker();
  File? postAssetPath;
  File? postAssetName;
  String? assetType;
  Size? imageSize;

  void getPostImage() async {
    removePostAsset();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postAssetPath = File(pickedFile.path);
      postAssetName = File(pickedFile.name);
      imageSize = ImageSizeGetter.getSize(FileInput(postAssetPath!));
      assetType = "image";
      emit(PostGetAssetState());
    }
  }

  void getPostVideo() async {
    removePostAsset();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      postAssetPath = File(pickedFile.path);
      postAssetName = File(pickedFile.name);
      assetType = "video";
      emit(PostGetAssetState());
    }
  }

  void removePostAsset() {
    postAssetPath = null;
    emit(PostDeleteImageState());
  }

  void createPostWithAsset(
      {@required String? text,
      required String dateTime,
      required BuildContext context}) {
    String? image;
    String? video;
    emit(PostCreateLoadingState());
    FirebaseStorage.instance
        .ref()
        .child("Posts/$uId/$postAssetName")
        .putFile(postAssetPath!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        if (assetType == "video") {
          image = null;
          video = value;
        } else {
          image = value;
          video = null;
        }
        createPost(
            text: text,
            dateTime: dateTime,
            postImage: image,
            postVideo: video,
            context: context);
      });
    });
  }

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  void createPost(
      {@required String? text,
      required String dateTime,
      String? postImage,
      String? postVideo,
      required BuildContext context}) {
    emit(PostCreateLoadingState());
    String postId = firebaseFirestore.collection("Posts").doc().id;
    PostModel post = PostModel(
        uId: uId!,
        text: text,
        dateTime: dateTime,
        postImage: postImage,
        imageHeight: imageSize?.height,
        imageWidth: imageSize?.width,
        postId: postId,
        postVideo: postVideo);
    firebaseFirestore
        .collection("Posts")
        .doc(postId)
        .set(post.toMap())
        .then((value) {
      emit(PostCreateSuccessState());
      removePostAsset();
      getPosts(false);
    }).catchError((err) {
      emit(PostCreateErrorState());
    });
  }

  List<PostModel> postsList = [];
  Map<String, List<String>> likes = {};
  Map<String, int> comments = {};
  List<String> likesUsersId = [];

  void getPosts(bool refresh) {
    postsList.clear();
    likes.clear();
    if (refresh == false) {
      emit(PostsGetLoadingState());
    }
    firebaseFirestore
        .collection("Posts")
        .orderBy("dateTime", descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        getPostsComments(element.id);
        getLikes(element.id).then((value) {
          likesUsersId = [];
          for (var element in value.docs) {
            likesUsersId.add(element.id);
          }
          if (value.docs.length == likesUsersId.length) {
            likes.addAll({element.id: likesUsersId});
            emit(PostsLikesGetState());
          }
          postsList.add(PostModel.fromJson(element.data()));
          if (value.docs.length == postsList.length) {
            emit(PostsGetSuccessState());
          }
        });
      }
    });
  }

  void getPostsComments(String postId) {
    firebaseFirestore
        .collection("Comments")
        .doc(postId)
        .collection("Comments")
        .snapshots()
        .listen((event) {
      comments.addAll({postId: event.docs.length});
    });
  }

  void likePost(String postId) {
    bool ownerLikeThePost = false;
    if (likes[postId] != null) {
      int length = likes[postId]!.length;
      if (length == 0) {
        addLike(postId);
      }
      for (String element in likes[postId]!) {
        if (element == uId) {
          ownerLikeThePost = true;
          removeLike(postId);
          break;
        } else {
          ownerLikeThePost = false;
        }
        if (likes[postId]?.indexOf(element) == length - 1 &&
            ownerLikeThePost == false) {
          addLike(postId);
        }
      }
    }
  }

  void addLike(String postId) {
    firebaseFirestore
        .collection("Likes")
        .doc(postId)
        .collection("Users")
        .doc(uId)
        .set({"userId": uId}).then((value) {
      emit(PostLikeSuccessState());
      getLikes(postId).then((value) => updateLikes(postId));
    });
  }

  void removeLike(String postId) {
    firebaseFirestore
        .collection("Likes")
        .doc(postId)
        .collection("Users")
        .doc(uId)
        .delete()
        .then((value) {
      PostLikeSuccessState();
      getLikes(postId).then((value) => updateLikes(postId));
    });
  }

  Future<QuerySnapshot> getLikes(String postId) {
    return firebaseFirestore
        .collection("Likes")
        .doc(postId)
        .collection("Users")
        .get();
  }

  updateLikes(String postId) {
    getLikes(postId).then((value) {
      List<String> users = [];
      for (var element in value.docs) {
        users.add(element.id);
      }
      if (value.docs.length == users.length) {
        likes.addAll({postId: users});
        emit(PostsLikesGetState());
      }
    });
  }

  postBodyChanged() {
    emit(PostBodyChanged());
  }

  downloadPostImage(String postImage) {
    emit(DownloadPostImageLoading());
    ImageDownloader.downloadImage(postImage).then((value) {
      emit(DownloadPostImageDone());
    }).catchError((err) {
      emit(DownloadPostImageFailed());
    });
  }
}
