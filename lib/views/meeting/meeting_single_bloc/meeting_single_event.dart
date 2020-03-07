import 'package:equatable/equatable.dart';

abstract class MeetingSingleEvent extends Equatable {
  const MeetingSingleEvent();
}

class FetchSingleMeeting extends MeetingSingleEvent {
  @override
  List<Object> get props => [];
}
