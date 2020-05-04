import 'package:flutter/material.dart';
import 'package:oneword/src/general/list_card.dart';
import 'package:oneword/src/state/user.dart';
import 'package:provider/provider.dart';

class Stats extends StatelessWidget {
  Stats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user =  Provider.of<UserState>(context);

    return ListView(
      primary: false,
      shrinkWrap: true,
      children: [
        ListCard(title: 'Standing', icon: Icons.center_focus_weak, trailing: Text(user.reputation.toString())),
        ListCard(title: 'Votes', icon: Icons.import_export, trailing: Text(user.numVotes.toString())),
        ListCard(title: 'Verified Reports', icon: Icons.gavel, trailing: Text(user.numVerifiedReports.toString())),
        ListCard(title: 'Posts', icon: Icons.whatshot, trailing: Text(user.numPosts.toString())),
        ListCard(title: 'Comments', icon: Icons.comment, trailing: Text(user.numComments.toString())),
        ListCard(title: 'Karma', icon: Icons.offline_bolt, trailing: Text(user.numComments.toString()))
      ],
    );
  }
}