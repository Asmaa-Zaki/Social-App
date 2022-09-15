abstract class CommentStates {}

class CommentInitState extends CommentStates {}

class GetCommentsSuccess extends CommentInitState {}

class GalleryFileSelected extends CommentStates {}

class GalleryImageShown extends CommentStates {}

class ChangeEmojiState extends CommentStates {}

class ChangeMessageIcon extends CommentStates {}

class ChangeKeyboardState extends CommentStates {}
