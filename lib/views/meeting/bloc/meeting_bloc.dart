import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meetinerary/models/meeting.dart';
import 'package:meetinerary/services/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './bloc.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  @override
  MeetingState get initialState => MeetingLoading();

  @override
  Stream<MeetingState> mapEventToState(
    MeetingEvent event,
  ) async* {
    if (event is FetchMeeting) {
      yield MeetingLoading();

      List<Meeting> meetings = await _fetchMeetings();

      if (meetings != null) {
        yield MeetingLoaded(meetings);
      } else {
        yield MeetingError('wayoo');
      }
    }
  }

  Future<List<Meeting>> _fetchMeetings() async {
    final _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString('token');
    final url = ApiClient.url;
    final response = await http.get(
      '$url/api/profile/meetings',
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List).map((i) =>
          Meeting.fromJson(i)).toList();
    } else {
      return null;
    }
  }
}
