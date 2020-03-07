import 'package:equatable/equatable.dart';
import 'package:meetinerary/models/meeting.dart';

abstract class MeetingState extends Equatable {
  const MeetingState();
}

class MeetingLoading extends MeetingState {
  @override
  List<Object> get props => [];
}

class MeetingLoaded extends MeetingState {
  final List<Meeting> meetings;

  MeetingLoaded(this.meetings);

  @override
  List<Object> get props => [this.meetings];
}

class MeetingError extends MeetingState {
  final String errorMessage;

  MeetingError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
