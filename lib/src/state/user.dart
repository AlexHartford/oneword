import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:oneword/src/state/post.dart';

import 'package:firebase_auth/firebase_auth.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Error, New }
enum Gender { Male, Female, Other }

const MIN_USERNAME_LENGTH = 3;
const MIN_PASSWORD_LENGTH = 8;
const VALID_USERNAME_REGEX = r'^[a-zA-Z0-9\-_]+$';

class UserState with ChangeNotifier {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser _user;

  String uid;
  String did;
  String name;
  int karma;
  int reputation;
  Gender gender;

  Map<String, Direction> votes = Map();

  Status _status = Status.Uninitialized;

  Status get status => _status;

  bool get isLinked => !_user.isAnonymous;

  @override
  String toString() => 'UID: $uid\nDID: $did\nName: $name\n$_status\nKarma: $karma\nRep: $reputation';

  UserState._() {
    try {
      retrieve();
    } catch (e) {
      _status = Status.Error;
    }
    _instance = this;
  }

  static UserState _instance;

  static UserState get instance => _instance ?? UserState._();

  Future<void> retrieve() async {
    _user = await _auth.currentUser();
    print('Current user: $_user');
    if (_user == null) {
      _status = Status.New;
      notifyListeners();
    } else {
      _status = Status.Authenticating;
      notifyListeners();
      await _getMetadata();
    }
  }

  // TODO: Check if DeviceID exists on a banned account
  Future<void> create() async {
    if (_user != null) return await _getMetadata();
    _status = Status.Authenticating;
    notifyListeners();

    AuthResult res = await _auth.signInAnonymously();
    _user = res.user;

    if (_user == null) {
      _status = Status.Error;
      notifyListeners();
    } else {
      await _getMetadata();
    }
  }

  String convertUsername(String username) => '$username@oneblank.io';

  Future<bool> checkUsername(String username) async =>
      (await _auth.fetchSignInMethodsForEmail(email: convertUsername(username))).isEmpty;

  Future<bool> update() async {
    // Updates like added posts, security questions
  }

  Future<bool> convert(String username, String password) async {
    String email = convertUsername(username);
    try {
      AuthCredential cred = EmailAuthProvider.getCredential(email: email, password: password);
      AuthResult res = await _user.linkWithCredential(cred);
      _user = res.user;
      _status = Status.Authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  addVote(String postId, Direction dir, {bool notify = false}) {
    votes[postId] == dir ? votes[postId] = Direction.None : votes[postId] = dir;
    // Fire and forget API call to user service
    if (notify) notifyListeners();
  }

  Direction getDirectionForPost(String postId) {
    return votes[postId] ?? Direction.None;
  }

  Image getDefaultAvatar() {
    switch (gender) {
      case (Gender.Female):
        return Image.asset('assets/images/jane.png');
      case (Gender.Male):
        return Image.asset('assets/images/john.png');
      case (Gender.Other):
      default:
        return Image.asset('assets/images/joan.png');
    }
  }

  Future<void> _getMetadata() async {
    // Call AWS to get karma, etc.
    // Handle in backend: If new user, return default values
    // else return existing values
    await Future.delayed(const Duration(seconds : 2));
    bool success = true;

    if (success) {
      print('Got metadata');
      uid = _user.uid;
      did = await _getUniqueId();
      name = 'Spunky Rat';
      karma = 100;
      reputation = 5;
      gender = Gender.Female;

      _status = Status.Authenticated;
      notifyListeners();
    } else {
      _status = Status.Error;
      notifyListeners();
    }
  }

  Future<String> _getUniqueId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }
}
