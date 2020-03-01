import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meetinerary/services/api_client.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final String url = ApiClient.url;
  SharedPreferences _preferences;

  Future<String> authenticate({
    @required String email,
    @required String password,
  }) async {

    final response = await http.post(
      '$url/api/login',
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    Map<String, dynamic> body = json.decode(response.body);

    if (response.statusCode == 200) {
      await Future.delayed(Duration(seconds: 1));
      
      return body['token'];
    }

    throw body['message'];
  }

  Future<void> deleteToken() async {
    _preferences = await SharedPreferences.getInstance();

    _preferences.remove('token');

    await Future.delayed(Duration(seconds: 1));

    return;
  }

  Future<void> persistToken(String token) async {
    _preferences = await SharedPreferences.getInstance();

    _preferences.setString('token', token);

    await Future.delayed(Duration(seconds: 1));

    return;
  }

  Future<bool> hasToken() async {
    _preferences = await SharedPreferences.getInstance();

    String token = _preferences.getString('token');

    await Future.delayed(Duration(seconds: 1));

    print("token: $token");

    if (token == null) return false;

    return token.isNotEmpty;
  }
}