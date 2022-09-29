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

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dioController = TextEditingController();

  void getUser() {
    emit(GetCurrentUserLoadingState());
    FirebaseFirestore.instance.collection("Users").doc(uId).get().then((value) {
      if (value.data() != null) {
        user = UserModel.fromJson(value.data()!);
        nameController.text = user!.name;
        dioController.text = user!.dio;
        phoneController.text = user!.phone;
      }
      emit(GetCurrentUserSuccessState());
    }).catchError((err) {
      emit(GetCurrentUserErrorState());
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

  UserModel? userWithId;
  List<UserModel> allUsers = [];
  UserModel? getUserWithId(String uId) {
    for (var element in users) {
      allUsers.add(element);
    }

    allUsers.add(user!);
    for (var element in allUsers) {
      if (element.uId == uId) {
        userWithId = element;
      }
    }
    return userWithId;
  }

  bool showUpdateButton = false;
  void userNewData() {
    showUpdateButton = false;
    emit(UserDataChanged());
    if (nameController.text != user?.name ||
        dioController.text != user?.dio ||
        phoneController.text != user?.phone) {
      showUpdateButton = true;
      emit(UserDataChanged());
    }
  }

  void userRemoveUpdates() {
    nameController.text = user!.name;
    dioController.text = user!.dio;
    phoneController.text = user!.phone;
    showUpdateButton = false;
    image = null;
    cover = null;
    emit(UserRemoveUpdates());
  }

  updateProfileData({String? image, String? cover, required bool updateImage}) {
    if (updateImage == false) {
      emit(UserProfileUpdateLoadingState());
    }
    user = UserModel(
        name: nameController.text,
        email: user!.email,
        phone: phoneController.text,
        password: user!.password,
        image: image ?? user!.image,
        cover: cover ?? user!.cover,
        dio: dioController.text,
        uId: uId!);
    FirebaseFirestore.instance
        .collection("Users")
        .doc(uId)
        .update(user!.toMap())
        .then((value) {
      if (updateImage == false) {
        showUpdateButton = false;
        emit(UserProfileUpdateSuccessState());
      }
      getUser();
    }).catchError((err) {
      if (updateImage == false) {
        emit(UserProfileUpdateErrorState());
      }
    });
  }

  File? image;
  File? cover;
  ImagePicker picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(GetGalleryImageSuccessState());
    }
  }

  Future getCover() async {
    final pickedCover = await picker.pickImage(source: ImageSource.gallery);
    if (pickedCover != null) {
      cover = File(pickedCover.path);
      emit(GetGalleryCoverSuccessState());
    }
  }

  FirebaseStorage storage = FirebaseStorage.instance;
  Future getCurrentImage(String type) {
    return storage.ref().child("Users/$type/$uId").listAll();
  }

  Future deletePrevImage(String profile, String type) {
    return storage.ref().child("Users/$type/$uId/$profile").delete();
  }

  Future uploadNewImage(bool profileImage) {
    return storage
        .ref()
        .child(
            "Users/${profileImage ? "Profiles" : "Covers"}/$uId/${Uri.file(profileImage ? image!.path : cover!.path).pathSegments.last}")
        .putFile(profileImage ? image! : cover!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImage ? image = null : cover = null;
        updateProfileData(
            updateImage: true,
            image: profileImage ? value : null,
            cover: !profileImage ? value : null);
      });
    });
  }

  updateProfileImage() {
    emit(UserImageUploadLoadingState());
    getCurrentImage("Profiles").then((value) {
      if (value.items.isNotEmpty) {
        deletePrevImage(
                Uri.file(value.items[0].fullPath).pathSegments.last, "Profiles")
            .then((value) {
          uploadNewImage(true).then((value) {
            emit(UserImageUploadSuccessState());
          }).catchError((err) {
            emit(UserImageUploadErrorState());
          });
        });
      } else {
        uploadNewImage(true).then((value) {
          emit(UserImageUploadSuccessState());
        }).catchError((err) {
          emit(UserImageUploadErrorState());
        });
      }
    });
  }

  updateProfileCover() {
    emit(UserCoverUploadLoadingState());
    getCurrentImage("Covers").then((value) {
      if (value.items.isNotEmpty) {
        deletePrevImage(
                Uri.file(value.items[0].fullPath).pathSegments.last, "Covers")
            .then((value) {
          uploadNewImage(false).then((value) {
            emit(UserCoverUploadSuccessState());
          }).catchError((error) {
            emit(UserCoverUploadErrorState());
          });
        });
      } else {
        uploadNewImage(false).then((value) {
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

  List<UserModel> likesUsers = [];
  getPostLikesUsers(List<String> usersId) {
    likesUsers = [];
    for (var uElement in users) {
      for (var element in usersId) {
        if (uElement.uId == element) {
          likesUsers.add(uElement);
        } else if (uId == element) {
          likesUsers.add(user!);
        }
      }
    }
  }

  List<UserModel> usersWithoutFriendsList = [];
  void usersWithoutFriends(List<String> friends) {
    usersWithoutFriendsList.clear();
    if (friends.isEmpty) {
      for (var element in users) {
        usersWithoutFriendsList.add(element);
        emit(GetUsersWithoutFriends());
      }
    } else {
      for (var element in users) {
        for (var fElement in friends) {
          if (element.uId != fElement) {
            usersWithoutFriendsList.add(element);
          }
        }
        emit(GetUsersWithoutFriends());
      }
    }
  }

  List<UserModel> friendsList = [];

  void getFriendsUsers(List<String> friends) {
    friendsList.clear();
    for (var element in users) {
      for (var fElement in friends) {
        if (element.uId == fElement) {
          friendsList.add(element);
        }
      }
    }
  }
}
