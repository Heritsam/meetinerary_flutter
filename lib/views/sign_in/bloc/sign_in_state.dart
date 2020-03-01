import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SignInState extends Equatable {
  const SignInState();
}

class SignInInitial extends SignInState {
  @override
  List<Object> get props => [];
}

class SignInLoading extends SignInState {
  @override
  List<Object> get props => [];
}

class SignInFailure extends SignInState {
  final String error;

  const SignInFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SignInFailure { error: $error }';
}
