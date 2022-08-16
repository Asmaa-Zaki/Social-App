abstract class UserStates{}

class UserInitState extends UserStates{}

class UserRegisterLoadingState extends UserStates{}
class UserRegisterSuccessState extends UserStates{}
class UserRegisterErrorState extends UserStates{}

class UserCreateLoadingState extends UserStates{}
class UserCreateSuccessState extends UserStates{}
class UserCreateErrorState extends UserStates{}


class UserLoginLoadingState extends UserStates{}
class UserLoginSuccessState extends UserStates{}
class UserLoginErrorState extends UserStates{}

class UserGetLoadingState extends UserStates{}
class UserGetSuccessState extends UserStates{}
class UserGetErrorState extends UserStates{}

class UsersGetLoadingState extends UserStates{}
class UsersGetSuccessState extends UserStates{}
class UsersGetErrorState extends UserStates{}

class UserImageEditSuccessState extends UserStates{}
class UserImageEditErrorState extends UserStates{}

class UserCoverEditSuccessState extends UserStates{}
class UserCoverEditErrorState extends UserStates{}

class UserImageUploadLoadingState extends UserStates{}
class UserImageUploadSuccessState extends UserStates{}
class UserImageUploadErrorState extends UserStates{}

class UserCoverUploadLoadingState extends UserStates{}
class UserCoverUploadSuccessState extends UserStates{}
class UserCoverUploadErrorState extends UserStates{}

class UserProfileUpdateLoadingState extends UserStates{}
class UserProfileUpdateSuccessState extends UserStates{}
class UserProfileUpdateErrorState extends UserStates{}

class UserLogoutSuccessState extends UserStates{}