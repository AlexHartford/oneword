import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtext;
  final Widget trailing;
  final onTap;

  ListCard(
      {Key key,
      @required this.icon,
      @required this.title,
      this.subtext,
      this.trailing,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      shape: Border(),
      child: InkWell(
        onTap: this.onTap,
        child: ListTile(
          title: Text(this.title),
          leading: Icon(icon),
          trailing: this.trailing,
          subtitle: this.subtext != null ? Text(this.subtext) : null,
        ),
      )
    );
  }
}
