import 'package:equatable/equatable.dart';

abstract class MeetingSingleState extends Equatable {
  const MeetingSingleState();
}

class MeetingSingleLoading extends MeetingSingleState {
  @override
  List<Object> get props => [];
}

class MeetingSingleLoaded extends MeetingSingleState {
  @override
  List<Object> get props => [];
}

class MeetingSingleError extends MeetingSingleState {
  final String errorMessage;

  MeetingSingleError(this.errorMessage);

  @override
  List<Object> get props => [this.errorMessage];
}
