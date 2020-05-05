import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:oneword/src/state/post.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:oneword/src/state/preferences.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Error, New, Deleted }
enum Gender { Male, Female, Other }

const MIN_USERNAME_LENGTH = 3;
const MIN_PASSWORD_LENGTH = 8;
const VALID_USERNAME_REGEX = r'^[a-zA-Z0-9\-_]+$';

class UserState with ChangeNotifier {

  FirebaseAuth _auth;
  FirebaseUser _user;

  Preferences _prefs;

  String uid;
  String did;
  String displayName;
  String username;
  Gender gender;
  bool banned;
  String bannedUntilDate;

  int karma;
  int reputation;
  int numVerifiedReports;
  int numPosts;
  int numComments;
  int numVotes;

  Map<String, Direction> _votes;

  Status _status = Status.Uninitialized;

  Status get status => _status;

  bool get isLinked => _user != null ? !_user.isAnonymous : false;

  Preferences get prefs => _prefs;

  notify() {
    notifyListeners();
  }

  @override
  String toString() => 'UID: $uid\nDID: $did\nName: $displayName\n$_status\nKarma: $karma\nRep: $reputation\nauth: $_auth';

  UserState._() {
    _auth = FirebaseAuth.instance;
    _prefs = Preferences();
    _votes = Map();
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

  String convertUsername(String username) => '$username@doeapp.io';
  String convertEmail(String email) => email.substring(0, email.indexOf('@'));

  Future<bool> checkUsername(String username) async =>
      (await _auth.fetchSignInMethodsForEmail(email: convertUsername(username))).isEmpty;

  Future<bool> update() async {
    // Updates like added posts, security questions
    return true;
  }

  Future<bool> convert(String username, String password) async {
    String email = convertUsername(username);
    try {
      AuthCredential cred = EmailAuthProvider.getCredential(email: email, password: password);
      AuthResult res = await _user.linkWithCredential(cred);
      _user = res.user;
      this.username = username;
      this.karma += 100;
      _status = Status.Authenticated;
      notifyListeners();
      update();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  addVote(String postId, Direction dir, {bool notify = false}) {
    _votes[postId] == dir ? _votes[postId] = Direction.None : _votes[postId] = dir;
    // Fire and forget API call to user service
    if (notify) notifyListeners();
  }

  Direction getDirectionForPost(String postId) {
    return _votes[postId] ?? Direction.None;
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

  Future<bool> reAuthenticate(String password) async {
    try {
      AuthCredential cred = EmailAuthProvider.getCredential(email: _user.email, password: password);
      AuthResult res = await _user.reauthenticateWithCredential(cred);
      _user = res.user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> delete() async {
    try {
      await _user.delete();
      await _prefs.clear();
    } catch (e) {
      print(e);
    }
    _status = Status.Deleted;
    notifyListeners();
  }

  Future<Map<bool, String>> changePassword(String currentPass, String newPass) async {
    try {
      AuthCredential cred = EmailAuthProvider.getCredential(email: _user.email, password: currentPass);
      AuthResult res = await _user.reauthenticateWithCredential(cred);
      _user = res.user;
      _user.updatePassword(newPass);
      return { true: 'Successfully updated password!' };
    } catch (e) {
      print(e);
      if (e.toString().contains('TOO_MANY_REQUESTS')) {
        return { false: 'Too many failed attempts.\nTry again later.' };
      } else if (e.toString().contains('The password is invalid or the user does not have a password')) {
        return { false: 'Current password is incorrect.' };
      } else {
        return { false: 'Please try again later.'};
      }
    }
  }

  Future<void> ban() async {
    this.banned = true;
    this.bannedUntilDate = '05-10-2020';
    // Update user
    notifyListeners();
  }

  Future<void> _getMetadata() async {
    // Call AWS to get karma, etc.
    // Handle in backend: If new user, return default values
    // else return existing values
    await Future.delayed(const Duration(seconds : 2));
    bool success = true;

    if (success) {
      print('Got metadata');
      try {
        if (!_user.isAnonymous) username = convertEmail(_user.email);
      } catch (e) {
        print(e);
      }
      uid = _user.uid;
      did = await _getUniqueId();
      displayName = 'Spunky Rat';
      karma = 100;
      reputation = 5;
      numComments = 602;
      numPosts = 123;
      numVotes = 1000;
      numVerifiedReports = 7;
      gender = Gender.Female;
      banned = false;

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
