import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:oneword/src/state/post.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:oneword/src/state/preferences.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Error, New, Deleted }
enum Gender { Male, Female, Other }

class UserState with ChangeNotifier {

  FirebaseAuth _auth;
  FirebaseUser _user;

  Preferences _prefs; // Local device preferences

  String uid; // Unique user ID
  String did; // Device ID
  String displayName; // Name to show on posts
  Gender gender;
  bool banned;
  String bannedUntilDate;

  List blockedUsers;
  List reportedUsers;

  int karma;
  int reputation;
  int numVerifiedReports;
  int numPosts;
  int numComments;
  int numVotes;

  String get email => _user.email;

  Map<String, Direction> _votes;

  Status _status = Status.Uninitialized;

  Status get status => _status;

  bool get isLinked => _user != null ? !_user.isAnonymous : false;

  Preferences get prefs => _prefs;

  void notify() {
    notifyListeners();
  }

  @override
  String toString() => 'UID: $uid\nDID: $did\nName: $displayName\n$_status\nKarma: $karma\nRep: $reputation\nauth: $_auth';

  UserState._() {
    _auth = FirebaseAuth.instance;
    _prefs = Preferences();
    _votes = Map();
    blockedUsers = [];
    reportedUsers = [];
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

  Future<bool> checkEmail(String email) async {
    try {
      return (await _auth.fetchSignInMethodsForEmail(email: email)).isEmpty;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> signInAsGuest() async {
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

  Future<bool> signInWithEmail(String email, String password) async {
    try {
      AuthResult res = await _auth.signInWithEmailAndPassword(email: email, password: password);
      _user = res.user;
      await _getMetadata();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
    _status = Status.New;
    notifyListeners();
  }

  Future<bool> createWithEmail(String email, String password) async {
    try {
      AuthResult res = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _user = res.user;
      _user.sendEmailVerification();
      await _getMetadata();
      _status = Status.Authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> convert(String email, String password) async {
    try {
      AuthCredential cred = EmailAuthProvider.getCredential(email: email, password: password);
      AuthResult res = await _user.linkWithCredential(cred);
      _user = res.user;
      this.karma += 100;
      _status = Status.Authenticated;
      notifyListeners();
      _setMetadata();
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
  
  Future<bool> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> ban() async {
    this.banned = true;
    this.bannedUntilDate = '05-10-2020';
    _setMetadata();
    notifyListeners();
  }

  Future<bool> _setMetadata() async {
    // Updates like added posts, security questions
    return true;
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
