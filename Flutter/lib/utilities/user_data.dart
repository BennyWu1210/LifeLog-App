import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

class User {
  final String username;
  late String _passwordHash;
  late String _salt;
  // TODO: refactor journal and goals here

  User(this.username, String password) {
    var rng = Random.secure();
    var saltBytes = List<int>.generate(16, (_) => rng.nextInt(256));
    _salt = base64Encode(saltBytes);
    _passwordHash = _hashPassword(password, _salt);
  }

  @override
  String toString() {
    return "name: $username, hash: $_passwordHash, salt: $_salt";
  }

  String _hashPassword(String password, String salt) {
    var key = utf8.encode(password + salt);
    var bytes = sha256.convert(key).bytes;
    return base64Encode(bytes);
  }

  bool verifyPassword(String password) {
    var hash = _hashPassword(password, _salt);
    return hash == _passwordHash;
  }

  Map<String, dynamic> toJson(){
    return {
      'username': username,
      'hash': _passwordHash,
      'salt': _salt
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    User user = User(json['username'], '');
    user._passwordHash = json['hash'];
    user._salt = json['salt'];
    return user;
  }

  factory User.empty(){
    User blank = User("", "");
    return blank;
  }


}