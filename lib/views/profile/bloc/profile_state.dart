import 'package:equatable/equatable.dart';
import 'package:meetinerary/models/profile.dart';
import 'package:meta/meta.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileLoading extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoaded extends ProfileState {
  final Profile profile;

  ProfileLoaded({@required this.profile});

  @override
  List<Object> get props => [this.profile];
}

class ProfileError extends ProfileState {
  final String errorMessage;

  ProfileError(this.errorMessage);

  @override
  List<Object> get props => [this.errorMessage];
}