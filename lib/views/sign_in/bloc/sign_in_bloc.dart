import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meetinerary/bloc/authentication_bloc.dart';
import 'package:meetinerary/bloc/authentication_event.dart';
import 'package:meetinerary/services/repository/user_repository.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  SignInBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  SignInState get initialState => SignInInitial();

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    if (event is SignInButtonPressed) {
      yield SignInLoading();

      try {
        final token = await userRepository.authenticate(
          email: event.email,
          password: event.password,
        );

        authenticationBloc.add(LoggedIn(token: token));
        yield SignInInitial();
      } catch (error) {
        yield SignInFailure(error: error.toString());
      }
    }
  }
}
