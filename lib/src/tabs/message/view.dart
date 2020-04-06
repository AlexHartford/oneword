import 'package:flutter/material.dart';
import 'package:oneword/src/tabs/message/contact.dart';

class Message extends StatelessWidget {
  Message({Key key}) : super(key: key);

  Future<bool> refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
        centerTitle: true
      ),
      body: RefreshIndicator(
        onRefresh: this.refresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            Contact(),
            Contact(),
            Contact(),
            Contact(),
            Contact(),
            Contact(),
            Contact(),
            Contact(),
            Contact(),
            Contact(),
            Contact(),
            Contact(),
            Contact(),
            Contact()
          ],
        ),
      )
    );
  }
}
