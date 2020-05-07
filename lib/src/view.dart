import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:oneword/src/state/user.dart';

import 'package:oneword/src/tabs/post/text.dart';
import 'package:oneword/src/tabs/feed/view.dart';
import 'package:oneword/src/tabs/message/view.dart';
import 'package:oneword/src/tabs/search/view.dart';
import 'package:oneword/src/tabs/account/view.dart';

enum Tab { Feed, Search, Message, Account }

class View extends HookWidget {

  View({Key key}) : super(key: key);

  final _tabs = <Tab, Widget> {
    Tab.Feed: Feed(key: PageStorageKey('Feed')),
    Tab.Search: Search(key: PageStorageKey('Search')),
    Tab.Message: Message(key: PageStorageKey('Message')),
    Tab.Account: Account(key: PageStorageKey('Account'))
  };

  @override
  Widget build(BuildContext context) {
    final _tab = useState(Tab.Feed);

    return Scaffold(
      body: Center(child: _tabs[_tab.value]),
      bottomNavigationBar: CustomBottomNav(tab: _tab),
    );
  }
}

class CustomBottomNav extends StatelessWidget {
  final ValueNotifier tab;

  CustomBottomNav({Key key, this.tab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomNavItem(
            icon: Icon(Icons.import_export),
            onPressed: () => tab.value = Tab.Feed,
            selected: tab.value == Tab.Feed,
          ),
          CustomNavItem(
            icon: Icon(Icons.search),
            onPressed: () => tab.value = Tab.Search,
            selected: tab.value == Tab.Search,
          ),
          PostNavItem(),
          CustomNavItem(
            icon: Icon(Icons.forum),
            onPressed: () => tab.value = Tab.Message,
            selected: tab.value == Tab.Message,
          ),
          CustomNavItem(
            icon: Icon(Icons.account_circle),
            onPressed: () => tab.value = Tab.Account,
            selected: tab.value == Tab.Account,
          )
        ],
      ),
    );
  }
}

class CustomNavItem extends StatelessWidget {
  final Icon icon;
  final VoidCallback onPressed;
  final bool selected;

  CustomNavItem({Key key, this.icon, this.onPressed, this.selected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: this.selected ? Colors.blue : Colors.grey,
      icon: this.icon,
      onPressed: this.onPressed
    );
  }
}

class PostNavItem extends StatelessWidget {

  PostNavItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);

    return RaisedButton(
      child: user.banned ? Icon(Icons.block) : Icon(Icons.edit),
      onPressed: user.banned ? null : () => Navigator.pushNamed(context, TextPost.route),
    );
  }
}