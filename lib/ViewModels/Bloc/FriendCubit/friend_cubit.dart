import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_cubit.dart';
import 'package:social_app/ViewModels/Components/components.dart';
import 'package:social_app/ViewModels/Constants/constants.dart';

import 'friend_states.dart';

class FriendCubit extends Cubit<FriendStates> {
  FriendCubit() : super(FriendInitState());

  static FriendCubit get(BuildContext context) => BlocProvider.of(context);

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void addFriend(String userId, BuildContext context) {
    UserCubit.get(context).getActiveDevices(userId);
    _addFriendInSent(userId).then((value) {
      _addFriendInReceive(userId).then((value) {
        emit(AddFriendSuccess());
        getAllFriendsDetails(false);
        sendNotification(
            context: context,
            body:
                "${UserCubit.get(context).getUserWithId(uId!)?.name} sent you a friend request",
            title: "New Friend",
            userId: userId,
            screen: "usersScreen");
      });
    });
  }

  Future<void> _addFriendInSent(String userId) {
    return _firebaseFirestore
        .collection("Friends")
        .doc(uId)
        .collection("Sent")
        .doc(userId)
        .set({"userId": userId});
  }

  Future<void> _addFriendInReceive(String userId) {
    return _firebaseFirestore
        .collection("Friends")
        .doc(userId)
        .collection("Received")
        .doc(uId)
        .set({"userId": uId});
  }

  void removeFriend(String userId, bool friendReq, bool removeReq) {
    _removeFriendInSent(userId, friendReq).then((value) {
      _removeFriendInReceive(userId, friendReq).then((value) {
        if (removeReq || !friendReq) {
          requests.remove(userId);
          emit(RemoveFriendSuccess());
        }
        if (!removeReq && friendReq) {
          emit(AcceptFriendSuccess(userId));
        }
        getAllFriendsDetails(friendReq);
      });
    });
  }

  Future<void> _removeFriendInSent(String userId, bool friendReq) {
    return _firebaseFirestore
        .collection("Friends")
        .doc(friendReq ? userId : uId)
        .collection("Sent")
        .doc(friendReq ? uId : userId)
        .delete();
  }

  Future<void> _removeFriendInReceive(String userId, bool friendReq) {
    return _firebaseFirestore
        .collection("Friends")
        .doc(friendReq ? uId : userId)
        .collection("Received")
        .doc(friendReq ? userId : uId)
        .delete();
  }

  void acceptFriend(String userId, BuildContext context) {
    UserCubit.get(context).getActiveDevices(userId);
    addToMyFriendList(userId).then((value) {
      addToSenderFriendList(userId).then((value) {
        removeFriend(userId, true, false);
        sendNotification(
            context: context,
            body:
                "${UserCubit.get(context).getUserWithId(uId!)?.name} accepted your friend request",
            title: "New Friend",
            userId: userId,
            screen: "chatsScreen");
      });
    });
  }

  Future addToMyFriendList(String userId) {
    return _firebaseFirestore
        .collection("Friends")
        .doc(uId)
        .collection("Accepted")
        .doc(userId)
        .set({"userId": userId});
  }

  Future addToSenderFriendList(String userId) {
    return _firebaseFirestore
        .collection("Friends")
        .doc(userId)
        .collection("Accepted")
        .doc(uId)
        .set({"userId": uId});
  }

  Map<String, String> requests = {};
  List<String> acceptedFriends = [];
  List<String> tempAcceptedFriends = [];
  getAllFriendsDetails(bool friendReq, {bool loading = false}) {
    acceptedFriends.clear();
    if (loading) emit(GetFriendsLoading());
    _getReceivedRequests().then((value) {
      friendsCollectionEmpty(value, friendReq, "receive");
      for (var element in value.docs) {
        requests.addAll({element.id: "Received"});
        if (!friendReq) {
          emit(GetFriendReceivedSuccess());
        }
      }
    });
    _getSentRequests().then((value) {
      friendsCollectionEmpty(value, friendReq, "sent");
      for (var element in value.docs) {
        requests.addAll({element.id: "Sent"});
        if (!friendReq) {
          emit(GetFriendSentSuccess());
        }
      }
    });
    _getAcceptedRequests().then((value) {
      friendsCollectionEmpty(value, friendReq, "accepted");
      for (var element in value.docs) {
        requests.addAll({element.id: "Accepted"});
        acceptedFriends.add(element.id);
        tempAcceptedFriends.add(element.id);
        if (!friendReq) {
          emit(GetFriendAcceptedSuccess());
        }
      }
    });
  }

  friendsCollectionEmpty(var value, bool friendReq, String type) {
    if (value.docs.length == 0) {
      if (!friendReq) {
        switch (type) {
          case "sent":
            emit(GetFriendSentSuccess());
            break;
          case "receive":
            emit(GetFriendReceivedSuccess());
            break;
          case "accepted":
            emit(GetFriendAcceptedSuccess());
        }
      }
    }
  }

  Future _getSentRequests() {
    return _firebaseFirestore
        .collection("Friends")
        .doc(uId)
        .collection("Sent")
        .get();
  }

  Future _getAcceptedRequests() {
    return _firebaseFirestore
        .collection("Friends")
        .doc(uId)
        .collection("Accepted")
        .get();
  }

  Future _getReceivedRequests() {
    return _firebaseFirestore
        .collection("Friends")
        .doc(uId)
        .collection("Received")
        .get();
  }
}
