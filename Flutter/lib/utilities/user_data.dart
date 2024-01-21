import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';

class User {
  late String username;
  late int userid;
  late String _passwordHash;
  late String _salt;
  String? profilePicturePath;
  // TODO: refactor journal and goals here

  User(this.username,
      String password,
      {this.profilePicturePath}) {
    var rng = Random.secure();
    var saltBytes = List<int>.generate(16, (_) => rng.nextInt(256));
    _salt = base64Encode(saltBytes);
    _passwordHash = _hashPassword(password, _salt);
    userid = username.hashCode; // TODO: Implement an actual user id system
  }

  ImageProvider get profilePicture {
    print("PFP PATH INIT");
    if (profilePicturePath == null) {
      return AssetImage("assets/images/sample_profile.jpg");
    } else {
      return FileImage(File(profilePicturePath!));
    }
  }

  @override
  String toString() {
    return "name: $username, hash: $_passwordHash, salt: $_salt, imgPath: $profilePicturePath";
  }

  String getHash(){
    return _passwordHash;
  }

  String getSalt(){
    return _salt;
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
      'salt': _salt,
      'profilePicturePath': profilePicturePath
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    User user = User(json['username'], '');
    user._passwordHash = json['hash'];
    user._salt = json['salt'];
    user.profilePicturePath = json['profilePicturePath'];
    return user;
  }

  factory User.empty(){
    User blank = User("", "");
    return blank;
  }


}