import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utilities/user_data.dart';

import '../utilities/user_data.dart';

// const backendURL = "localhost:8080"; // IOS emulator
const backendURL = "10.0.2.2:8080"; // Android emulator
Future<void> backendGet() async {
  /*
  function for testing only
  */

  final response = await http.get(Uri.parse('http://$backendURL/journal'));
  print("#########\n########## backendGet");
  if (response.statusCode == 200) {
    print('Response data: ${response.body}');
  } else {
    throw Exception('Request failed with status: ${response.statusCode}.');
  }
  print("");
}

Future<void> signup(String username, String password) async {
  User newUser = User(username, password);
}

Future<http.Response> authenticate(String username, String password) async {
  return http.post(Uri.parse('http://$backendURL/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'username': username, 'password': password}));
}
