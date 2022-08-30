abstract class PostAppStates {}

class PostAppInitState extends PostAppStates {}

class PostGetImageState extends PostAppStates {}

class PostDeleteImageState extends PostAppStates {}

class PostCreateLoadingState extends PostAppStates {}

class PostCreateSuccessState extends PostAppStates {}

class PostCreateErrorState extends PostAppStates {}

class PostsGetLoadingState extends PostAppStates {}

class PostsGetSuccessState extends PostAppStates {}

class PostsGetErrorState extends PostAppStates {}

class PostLikeSuccessState extends PostAppStates {}

class PostLikeErrorState extends PostAppStates {}

class PostsLikesGetState extends PostAppStates {}

class PostBodyChanged extends PostAppStates {}
