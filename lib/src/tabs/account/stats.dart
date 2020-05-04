import 'package:flutter/material.dart';
import 'package:oneword/src/general/list_card.dart';
import 'package:oneword/src/state/user.dart';
import 'package:provider/provider.dart';

class Stats extends StatelessWidget {
  Stats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user =  Provider.of<UserState>(context);

    _generateText(int stat) {
      return Text(
        stat.toString(),
        style: TextStyle(
          fontSize: 16
        ),
      );
    }

    return ListView(
      primary: false,
      shrinkWrap: true,
      children: [
        ListCard(title: 'Karma', icon: Icons.offline_bolt, trailing: _generateText(user.karma)),
        ListCard(title: 'Standing', icon: Icons.center_focus_weak, trailing: _generateText(user.reputation)),
        ListCard(title: 'Posts', icon: Icons.whatshot, trailing: _generateText(user.numPosts)),
        ListCard(title: 'Comments', icon: Icons.comment, trailing: _generateText(user.numComments)),
        ListCard(title: 'Votes', icon: Icons.import_export, trailing: _generateText(user.numVotes)),
        ListCard(title: 'Verified Reports', icon: Icons.gavel, trailing: _generateText(user.numVerifiedReports)),
      ],
    );
  }
}