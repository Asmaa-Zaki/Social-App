abstract class PostAppStates {}

class PostAppInitState extends PostAppStates {}

class PostGetImageState extends PostAppStates {}

class PostDeleteImageState extends PostAppStates {}

class PostUploadImageLoadingState extends PostAppStates {}

class PostUploadImageSuccessState extends PostAppStates {}

class PostUploadImageErrorState extends PostAppStates {}

class PostCreateLoadingState extends PostAppStates {}

class PostCreateSuccessState extends PostAppStates {}

class PostCreateErrorState extends PostAppStates {}

class PostsGetLoadingState extends PostAppStates {}

class PostsGetSuccessState extends PostAppStates {}

class PostsGetErrorState extends PostAppStates {}

class PostLikeSuccessState extends PostAppStates {}

class PostLikeErrorState extends PostAppStates {}
