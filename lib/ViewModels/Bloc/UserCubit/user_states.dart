abstract class UserStates {}

class UserInitState extends UserStates {}

class UserRegisterLoadingState extends UserStates {}

class UserRegisterSuccessState extends UserStates {}

class UserRegisterErrorState extends UserStates {
  final String errorMessage;

  UserRegisterErrorState(this.errorMessage);
}

class UserCreateLoadingState extends UserStates {}

class UserCreateSuccessState extends UserStates {}

class UserCreateErrorState extends UserStates {}

class UserLoginLoadingState extends UserStates {}

class UserLoginSuccessState extends UserStates {}

class UserLoginErrorState extends UserStates {
  final String errorMessage;

  UserLoginErrorState(this.errorMessage);
}

class GetCurrentUserLoadingState extends UserStates {}

class GetCurrentUserSuccessState extends UserStates {}

class GetCurrentUserErrorState extends UserStates {}

class UsersGetLoadingState extends UserStates {}

class UsersGetSuccessState extends UserStates {}

class UsersGetErrorState extends UserStates {}

class GetGalleryImageSuccessState extends UserStates {}

class GetGalleryCoverSuccessState extends UserStates {}

class UserImageUploadLoadingState extends UserStates {}

class UserImageUploadSuccessState extends UserStates {}

class UserImageUploadErrorState extends UserStates {}

class UserCoverUploadLoadingState extends UserStates {}

class UserCoverUploadSuccessState extends UserStates {}

class UserCoverUploadErrorState extends UserStates {}

class UserProfileUpdateLoadingState extends UserStates {}

class UserProfileUpdateSuccessState extends UserStates {}

class UserProfileUpdateErrorState extends UserStates {}

class UserLogoutSuccessState extends UserStates {}

class UserPasswordVisibility extends UserStates {}

class UserDataChanged extends UserStates {}

class UserRemoveUpdates extends UserStates {}
