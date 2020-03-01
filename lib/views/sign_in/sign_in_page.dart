import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetinerary/bloc/authentication_bloc.dart';
import 'package:meetinerary/services/repository/user_repository.dart';
import 'package:meetinerary/views/sign_in/bloc/sign_in_bloc.dart';
import 'package:meetinerary/views/sign_in/sign_in_form.dart';

class SignInPage extends StatelessWidget {
  final UserRepository userRepository;

  SignInPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return SignInBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: Stack(
          children: <Widget>[
            FlareActor(
              'assets/login.flr',
              fit: BoxFit.cover,
              alignment: FractionalOffset.topCenter,
              animation: 'Flow',
            ),
            SignInForm(),
          ],
        ),
      ),
    );
  }
}
