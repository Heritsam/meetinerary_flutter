import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetinerary/services/repository/user_repository.dart';
import 'package:meetinerary/themes/theme.dart';
import 'package:meetinerary/views/_widgets/loading_indicator_widget.dart';
import 'package:meetinerary/views/home/home_page.dart';
import 'package:meetinerary/views/sign_in/sign_in_page.dart';

import 'bloc/bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();

  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(userRepository: userRepository)
          ..add(AppStarted());
      },
      child: MyApp(userRepository: userRepository),
    ),
  );
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  MyApp({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meetinerary',
      theme: themeData,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        // ignore: missing_return
        builder: (context, state) {
          if (state is AuthenticationUninitialized) {
            return Scaffold(
              body: LoadingIndicatorWidget(),
            );
          }

          if (state is AuthenticationAuthenticated) {
            return HomePage();
          }

          if (state is AuthenticationUnauthenticated) {
            return SignInPage(userRepository: userRepository);
          }

          if (state is AuthenticationLoading) {
            return Scaffold(
              body: LoadingIndicatorWidget(),
            );
          }
        },
      ),
    );
  }
}
