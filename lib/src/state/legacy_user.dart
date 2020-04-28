import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:oneword/src/state/post.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Error, New }

class UserState with ChangeNotifier {
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
    _status = Status.Authenticating;
    notifyListeners();

    await Future.delayed(const Duration(seconds : 2));
    this.id = await _getUniqueId();

    // Found in DB, set fields
    if (this.id == '123') {
      this.name = 'Sharp Tiger';
      this.karma = 69;
      this.reputation = 420;

      _status = Status.Authenticated;
      notifyListeners();
    } else {
      _status = Status.New;
      notifyListeners();
    }
  }

  Future<void> create() async {
    _status = Status.Authenticating;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    // Not found in DB, create new user
    this.name = 'Dull Cat';
    this.karma = 100;
    this.reputation = 5;

    _status = Status.Authenticated;
    notifyListeners();
  }

  addVote(String postId, Direction dir, {bool notify = false}) {
    votes[postId] == dir ? votes[postId] = Direction.None : votes[postId] = dir;
    // Fire and forget API call to user service
    if (notify) notifyListeners();
  }

  Direction getDirectionForPost(String postId) {
    return votes[postId] ?? Direction.None;
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