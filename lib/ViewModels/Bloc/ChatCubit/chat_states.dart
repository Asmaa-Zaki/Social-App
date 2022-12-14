abstract class ChatStates {}

class ChatInit extends ChatStates {}

class GetChatLoading extends ChatStates {}

class GetChatSuccess extends ChatStates {}

class MessageSendingLoading extends ChatStates {}

class MessageSendSuccess extends ChatStates {}

class MessageSendError extends ChatStates {}

class ChangeMessageIcon extends ChatStates {}

class ChangeEmojiState extends ChatStates {}

class GalleryFileSelected extends ChatStates {}
