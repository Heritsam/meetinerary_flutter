import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class MeetingSingleBloc extends Bloc<MeetingSingleEvent, MeetingSingleState> {
  @override
  MeetingSingleState get initialState => MeetingSingleLoading();

  @override
  Stream<MeetingSingleState> mapEventToState(
    MeetingSingleEvent event,
  ) async* {
    if (event is FetchSingleMeeting) {

    }
  }
}
