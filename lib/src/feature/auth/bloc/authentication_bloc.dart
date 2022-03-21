import 'package:hotle_attendnce_admin/src/feature/auth/model/user_model.dart';
import 'package:hotle_attendnce_admin/src/feature/auth/repository/auth_repository.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/utils/service/storage.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  /// {@macro counter_bloc}
  AuthenticationBloc() : super(Authenticating());
  AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  Storage _storage = Storage();
  UserModel? userModel;
  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is CheckingAuthenticationStarted) {
      yield Initializing();
      userModel = await _storage.getCurrentUser();
      if (userModel == null) {
        yield NotAuthenticated();
      } else {
        // if already login  return token
        // save public in the whole app that use token to access all function
        ApiProvider.accessToken = userModel!.token;
        yield Authenticated(userModel: userModel!);
      }
      // String? _token = await _authenticationRepository.getToken();
      // if (_token == null) {
      //   yield NotAuthenticated();
      // } else {
      //   ApiProvider.accessToken = _token;

      //   yield Authenticated(token: _token);
      // }
    }
    if (event is AuthenticationStarted) {
      yield Authenticating();
      // if use to login , save token via event
      await _storage.saveCurrentUser(user: event.userModel);
      // await _authenticationRepository.saveToken(token: event.userModel);
      // ApiProvider.accessToken = event.token;
      // print(userModel!.name);
      yield Authenticated(userModel: event.userModel);
    }
    if (event is LogoutPressed) {
      yield LoggingOut();
      // await _authenticationRepository.removeToken();
      await _storage.deleteCurrentUser();
      ApiProvider.accessToken = '';
      await Future.delayed(Duration(seconds: 1));
      yield NotAuthenticated();
    }
  }
}
