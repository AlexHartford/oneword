import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:oneword/src/state/feed.dart';

import 'package:oneword/src/tabs/post/button.dart';
import 'package:oneword/src/tabs/post/text.dart';

import 'package:oneword/src/tabs/home/view.dart';
import 'package:oneword/src/tabs/message/view.dart';
import 'package:oneword/src/tabs/search/view.dart';
import 'package:oneword/src/tabs/account/view.dart';

class View extends HookWidget {

  View({Key key}) : super(key: key);

  final _widgetOptions = <Widget>[
    Home(key: PageStorageKey('Home')),
    Search(key: PageStorageKey('Search')),
    // TODO: If you miss the raised button, this route gets hit.  FIX
    TextPost(),
    Message(key: PageStorageKey('Message')),
    Account(key: PageStorageKey('Account'))
  ];

  final _items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      title: Text('Home'),
      icon: Icon(Icons.import_export)),
    BottomNavigationBarItem(
      title: Text('Search'),
      icon: Icon(Icons.search)),
    BottomNavigationBarItem(
      title: Text('Post'),
      icon: PostButton()
    ),
    BottomNavigationBarItem(
      title: Text('Message'),
      icon: Icon(Icons.message)),
    BottomNavigationBarItem(
      title: Text('Account'),
      icon: Icon(Icons.account_circle))
  ];

  @override
  Widget build(BuildContext context) {
    final _selected = useState(0);

    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selected.value)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: _items,
        currentIndex: _selected.value,
        onTap: (index) => _selected.value = index,
      ),
    );
  }
}