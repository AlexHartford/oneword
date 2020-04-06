import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:oneword/src/state/user.dart';

import 'package:oneword/src/tabs/home/post.dart';

class Home extends StatelessWidget {
  static const route = '/home';

  Home({Key key}) : super(key: key);

  Future<bool> refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby'),
        centerTitle: true,
        actions: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.bolt),
                  Text(
                    '${user.karma}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
                ],
              ),
          ))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: this.refresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            SizedBox(height: 4.0),
            Post(),
            Post(),
            Post(),
            Post(),
            Post(),
            Post()
          ],
        ),
      )
    );
  }
}
