import 'package:equatable/equatable.dart';

abstract class MeetingEvent extends Equatable {
  const MeetingEvent();
}

class FetchMeeting extends MeetingEvent {
  @override
  List<Object> get props => [];
}
