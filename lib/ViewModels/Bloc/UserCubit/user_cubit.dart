import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_states.dart';

import '../../../Models/UserModel/user_model.dart';
import '../../Constants/constants.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(UserInitState());

  static UserCubit get(BuildContext context) => BlocProvider.of(context);

  bool isPasswordInVisible = true;
  changeLoginPassword() {
    isPasswordInVisible = !isPasswordInVisible;
    emit(UserPasswordVisibility());
  }

  UserModel? user;
  void register(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    emit(UserRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(
          email: email,
          password: password,
          name: name,
          phone: phone,
          uId: value.user!.uid);
      uId = value.user!.uid;
      emit(UserRegisterSuccessState());
    }).catchError((err) {
      String message = "Error";
      FirebaseAuthException e = err;
      if (e.code == "email-already-in-use") {
        message = "Email already In Use";
      } else if (e.code == "invalid-email") {
        message = "Invalid Email";
      } else if (e.code == "weak-password") {
        message = "Weak Password";
      }
      emit(UserRegisterErrorState(message));
    });
  }

  void createUser({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String uId,
  }) {
    user = UserModel(
        name: name,
        email: email,
        phone: phone,
        password: password,
        uId: uId,
        image:
            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
        cover:
            "https://png.pngtree.com/element_our/png/20180917/business-background-white-style-png_74535.jpg",
        dio: "Your Dio here");
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .set(user!.toMap())
        .then((value) {
      getUsers();
      getUser();
    }).catchError((err) {
      emit(UserCreateErrorState());
    });
  }

  void signIn({@required email, @required password}) {
    emit(UserLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      uId = value.user?.uid;
      getUsers();
      getUser();
      emit(UserLoginSuccessState());
    }).catchError((err) {
      String message = "Error";
      FirebaseAuthException e = err;
      if (e.code == "user-not-found") {
        message = "No user found with this email";
      } else if (e.code == "invalid-email") {
        message = "Invalid Email";
      } else if (e.code == "wrong-password") {
        message = "Incorrect Password";
      }
      emit(UserLoginErrorState(message));
    });
  }

  void getUser() {
    emit(UserGetLoadingState());
    FirebaseFirestore.instance.collection("Users").doc(uId).get().then((value) {
      if (value.data() != null) {
        user = UserModel.fromJson(value.data()!);
      }
      emit(UserGetSuccessState());
    }).catchError((err) {
      emit(UserGetErrorState());
    });
  }

  List<UserModel> users = [];
  void getUsers() {
    users = [];
    emit(UsersGetLoadingState());
    FirebaseFirestore.instance.collection("Users").get().then((value) {
      for (var element in value.docs) {
        if (element.data()["uId"] != uId) {
          users.add(UserModel.fromJson(element.data()));
        }
      }
      emit(UsersGetSuccessState());
    }).catchError((err) {
      emit(UsersGetErrorState());
    });
  }

  UserModel? postUser;
  List<UserModel> allUsers = [];
  UserModel? getPostOwner(String uId) {
    for (var element in users) {
      allUsers.add(element);
    }

    allUsers.add(user!);
    for (var element in allUsers) {
      if (element.uId == uId) {
        postUser = element;
      }
    }
    return postUser;
  }

  updateProfileData(
      {required String name,
      required String phone,
      required String dio,
      String? image,
      String? cover}) {
    emit(UserProfileUpdateLoadingState());
    user = UserModel(
        name: name,
        email: user!.email,
        phone: phone,
        password: user!.password,
        image: image ?? user!.image,
        cover: cover ?? user!.cover,
        dio: dio,
        uId: uId!);
    FirebaseFirestore.instance
        .collection("Users")
        .doc(uId)
        .update(user!.toMap())
        .then((value) {
      emit(UserProfileUpdateSuccessState());
      getUser();
    }).catchError((err) {
      emit(UserProfileUpdateErrorState());
    });
  }

  File? image;
  File? cover;
  ImagePicker picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(UserImageEditSuccessState());
    } else {
      emit(UserImageEditErrorState());
    }
  }

  Future getCover() async {
    final pickedCover = await picker.pickImage(source: ImageSource.gallery);
    if (pickedCover != null) {
      cover = File(pickedCover.path);
      emit(UserCoverEditSuccessState());
    } else {
      emit(UserCoverEditErrorState());
    }
  }

  FirebaseStorage storage = FirebaseStorage.instance;
  Future getCurrentImage(String type) {
    return storage.ref().child("Users/$type/$uId").listAll();
  }

  Future deletePrefImage(String profile, String type) {
    return storage.ref().child("Users/$type/$uId/$profile").delete();
  }

  Future uploadNewImage(
      String name, String phone, String dio, bool profileImage) {
    return storage
        .ref()
        .child(
            "Users/${profileImage ? "Profiles" : "Covers"}/$uId/${Uri.file(profileImage ? image!.path : cover!.path).pathSegments.last}")
        .putFile(profileImage ? image! : cover!)
        .then((value) {
      profileImage
          ? emit(UserImageUploadSuccessState())
          : emit(UserCoverEditSuccessState());
      value.ref.getDownloadURL().then((value) {
        profileImage ? image = null : cover = null;
        updateProfileData(
            name: name,
            phone: phone,
            dio: dio,
            image: profileImage ? value : null,
            cover: !profileImage ? value : null);
      });
    });
  }

  updateProfileImage(String name, String phone, String dio) {
    emit(UserImageUploadLoadingState());
    getCurrentImage("Profiles").then((value) {
      if (value.items.isNotEmpty) {
        deletePrefImage(
                Uri.file(value.items[0].fullPath).pathSegments.last, "Profiles")
            .then((value) {
          uploadNewImage(name, phone, dio, true).then((value) {
            emit(UserImageUploadSuccessState());
          }).catchError((err) {
            emit(UserImageUploadErrorState());
          });
        });
      } else {
        uploadNewImage(name, phone, dio, true).then((value) {
          emit(UserImageUploadSuccessState());
        }).catchError((err) {
          emit(UserImageUploadErrorState());
        });
      }
    });
  }

  updateProfileCover(String name, String phone, String dio) {
    emit(UserCoverUploadLoadingState());
    getCurrentImage("Covers").then((value) {
      if (value.items.isNotEmpty) {
        deletePrefImage(
                Uri.file(value.items[0].fullPath).pathSegments.last, "Covers")
            .then((value) {
          uploadNewImage(name, phone, dio, false).then((value) {
            emit(UserCoverUploadSuccessState());
          }).catchError((error) {
            emit(UserCoverUploadErrorState());
          });
        });
      } else {
        uploadNewImage(name, phone, dio, false).then((value) {
          emit(UserCoverUploadSuccessState());
        }).catchError((error) {
          emit(UserCoverUploadErrorState());
        });
      }
    });
  }

  void logOut() {
    FirebaseAuth.instance.signOut().then((value) {
      emit(UserLogoutSuccessState());
    });
  }
}
