abstract class AuthStates{}

class AuthInitialState extends AuthStates{}

class RegisterSuccessState extends AuthStates{}
class RegisterErrorState extends AuthStates{}

class LoginSuccessState extends AuthStates{}
class LoginErrorState extends AuthStates{}

class ChangePasswordVisibilityState extends AuthStates{}

