import 'package:http/http.dart' as http;
import 'dart:convert';

const backendURL = "localhost:8080";
Future<void> backendGet() async {
  /*
  function for testing only

  android emulator:
  final response = await http.get(Uri.parse('http://10.0.2.2:3000/ping'));

  ios emulator:
  final response = await http.get(Uri.parse('http://localhost:3000/ping'));
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

Future<http.Response> authenticate(String username, String password) async {
  return http.post(Uri.parse('http://$backendURL/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'username': username, 'password': password}));
}
