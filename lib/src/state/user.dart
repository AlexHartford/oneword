import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:oneword/src/state/post.dart';

import 'package:firebase_auth/firebase_auth.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Error, New }

class UserState with ChangeNotifier {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser user;

  String id;
  String name;
  int karma;
  int reputation;

  Map<String, Direction> votes = Map();

  Status _status = Status.Uninitialized;

  Status get status => _status;

  @override
  String toString() => 'ID: $id\nName: $name\n$_status\nKarma: $karma\nRep: $reputation';

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
    this.user = await _auth.currentUser();
    print('Current user: ${this.user}');
    if (this.user == null) {
      _status = Status.New;
      notifyListeners();
    } else {
      _status = Status.Authenticating;
      notifyListeners();
      await _getMetadata();
    }
  }

  Future<void> create() async {
    _status = Status.Authenticating;
    notifyListeners();

    AuthResult res = await _auth.signInAnonymously();
    this.user = res.user;

    if (this.user == null) {
      _status = Status.Error;
      notifyListeners();
    } else {
      await _getMetadata();
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

  Future<void> _getMetadata() async {
    // Call AWS to get karma, etc.
    // Handle in backend: If new user, return default values
    // else return existing values
    await Future.delayed(const Duration(seconds : 2));
    bool success = true;

    if (success) {
      print('Got metadata');
      this.id = this.user.uid;
      this.name = 'Spunky Rat';
      this.karma = 100;
      this.reputation = 5;

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
