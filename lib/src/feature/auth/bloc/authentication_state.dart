import 'package:equatable/equatable.dart';
import 'package:hotle_attendnce_admin/src/feature/auth/model/user_model.dart';

abstract class AuthenticationState extends Equatable {
  // final String token;
  // final UserModel userModel;
  @override
  List<Object> get props => [];
  AuthenticationState();
}

class Initializing extends AuthenticationState {
  // Initializing()
  //     : super(
  //           token: "",
  //           userModel: UserModel(id: "", token: "", name: "", email: ""));
}

class Authenticated extends AuthenticationState {
  final UserModel userModel;
  Authenticated({required this.userModel});
}

class Authenticating extends AuthenticationState {
  // Authenticating()
  //     : super(
  //           token: "",
  //           userModel: UserModel(id: "", token: "", name: "", email: ""));
}

class NotAuthenticated extends AuthenticationState {
  // NotAuthenticated()
  //     : super(
  //           token: "",
  //           userModel: UserModel(id: "", token: "", name: "", email: ""));
}

class ErrorAuthentication extends AuthenticationState {
  final dynamic error;
  ErrorAuthentication({required this.error});
  // :
  //  super(
  //       token: "",
  //       userModel: UserModel(id: "", token: "", name: "", email: ""));

}

class LoggingOut extends AuthenticationState {
  // LoggingOut()
  //     : super(
  //           token: "",
  //           userModel: UserModel(id: "", token: "", name: "", email: ""));
}

class Loggedout extends AuthenticationState {
  // Loggedout()
  //     : super(
  //           token: "",
  //           userModel: UserModel(id: "", token: "", name: "", email: ""));
}
