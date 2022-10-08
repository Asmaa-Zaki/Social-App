abstract class FriendStates {}

class FriendInitState extends FriendStates {}

class AddFriendSuccess extends FriendStates {}

class RemoveFriendSuccess extends FriendStates {}

class AcceptFriendSuccess extends FriendStates {
  final String acceptedFriend;

  AcceptFriendSuccess(this.acceptedFriend);
}

class GetFriendSentSuccess extends FriendStates {}

class GetFriendsLoading extends FriendStates {}

class GetFriendReceivedSuccess extends FriendStates {}

class GetFriendAcceptedSuccess extends FriendStates {}

class GetAllFriendsSuccess extends FriendStates {}
