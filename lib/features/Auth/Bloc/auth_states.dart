abstract class AuthStates{}

class AuthInitialState extends AuthStates{}

class RegisterSuccessState extends AuthStates{}
class RegisterErrorState extends AuthStates{}

class LoginSuccessState extends AuthStates{}
class LoginErrorState extends AuthStates{}

class FacebookLoginSuccessState extends AuthStates{}
class FacebookLoginErrorState extends AuthStates{}

class FacebookLoginCheckedSuccessState extends AuthStates{}
class FacebookLoginCheckedErrorState extends AuthStates{}

class ChangePasswordVisibilityState extends AuthStates{}

