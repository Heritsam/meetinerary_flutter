import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meetinerary/models/profile.dart';
import 'package:meetinerary/services/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  @override
  ProfileState get initialState => ProfileLoading();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is FetchProfile) {
      yield ProfileLoading();

      Profile profile = await _fetchProfile();

      if (profile != null) {
        yield ProfileLoaded(profile: profile);
      } else {
        yield ProfileError('Oops! something\'s wrong here.');
      }
    }
  }

  Future<Profile> _fetchProfile() async {
    final _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString('token');
    final url = ApiClient.url;
    final response = await http.get(
      '$url/api/profile',
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return profileFromJson(response.body);
    } else {
      return null;
    }
  }
}
