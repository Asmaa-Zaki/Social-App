import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/FriendBloc/friend_states.dart';
import 'package:social_app/ViewModels/Constants/constants.dart';

class FriendCubit extends Cubit<FriendStates> {
  FriendCubit() : super(FriendInitState());

  static FriendCubit get(BuildContext context) => BlocProvider.of(context);

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void addFriend(String userId) {
    _addFriendInSent(userId).then((value) {
      _addFriendInReceive(userId).then((value) {
        emit(AddFriendSuccess());
        getAllFriendsDetails();
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

  void removeFriend(String userId, bool friendReq) {
    _removeFriendInSent(userId, friendReq).then((value) {
      _removeFriendInReceive(userId, friendReq).then((value) {
        emit(RemoveFriendSuccess());
        getAllFriendsDetails();
      });
    });
  }

  Future<void> _removeFriendInSent(String userId, bool acceptReq) {
    return _firebaseFirestore
        .collection("Friends")
        .doc(acceptReq ? userId : uId)
        .collection("Sent")
        .doc(acceptReq ? uId : userId)
        .delete();
  }

  Future<void> _removeFriendInReceive(String userId, bool acceptReq) {
    return _firebaseFirestore
        .collection("Friends")
        .doc(acceptReq ? uId : userId)
        .collection("Received")
        .doc(acceptReq ? userId : uId)
        .delete();
  }

  void acceptFriend(String userId) {
    addToMyFriendList(userId).then((value) {
      addToSenderFriendList(userId).then((value) {
        removeFriend(userId, true);
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
  getAllFriendsDetails() {
    requests.clear();
    acceptedFriends.clear();
    _getAcceptedRequests().then((value) {
      for (var element in value.docs) {
        requests.addAll({element.id: "Accepted"});
        acceptedFriends.add(element.id);
        emit(GetAllRequestsSuccess());
      }
    });
    _getSentRequests().then((value) {
      for (var element in value.docs) {
        requests.addAll({element.id: "Sent"});
        emit(GetAllRequestsSuccess());
      }
    });
    _getReceivedRequests().then((value) {
      for (var element in value.docs) {
        requests.addAll({element.id: "Received"});
        emit(GetAllRequestsSuccess());
      }
    });
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
