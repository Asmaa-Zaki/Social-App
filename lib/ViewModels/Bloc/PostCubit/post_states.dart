abstract class PostStates {}

class PostAppInitState extends PostStates {}

class PostGetAssetState extends PostStates {}

class PostDeleteImageState extends PostStates {}

class PostCreateLoadingState extends PostStates {}

class PostCreateSuccessState extends PostStates {}

class PostCreateErrorState extends PostStates {}

class PostsGetLoadingState extends PostStates {}

class PostsGetSuccessState extends PostStates {}

class PostsGetErrorState extends PostStates {}

class PostLikeSuccessState extends PostStates {}

class PostLikeErrorState extends PostStates {}

class PostsLikesGetState extends PostStates {}

class PostBodyChanged extends PostStates {}

class DownloadPostImageLoading extends PostStates {}

class DownloadPostImageDone extends PostStates {}

class DownloadPostImageFailed extends PostStates {}

class GetPostImageSize extends PostStates {}
