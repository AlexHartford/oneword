import 'package:flutter/material.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Error, New }

class User with ChangeNotifier {
  final String id;
  String name;
  int karma;
  int reputation;

  Status _status = Status.Uninitialized;
  Status get status => _status;

  @override
  String toString() => '$id·$name: $_status\nKarma: $karma\nRep: $reputation';

  // Attempt to get from DB, else create
  User(this.id) {
    try {
      retrieve();
    } catch (e) {
      _status = Status.Error;
    }
  }

  Future<void> retrieve() async {
    _status = Status.Authenticating;
    notifyListeners();

    await Future.delayed(const Duration(seconds : 2));

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

    await Future.delayed(const Duration(seconds : 2));

    // Not found in DB, create new user
    this.name = 'Dull Cat';
    this.karma = 100;
    this.reputation = 5;

    _status = Status.Authenticated;
    notifyListeners();
  }
}
