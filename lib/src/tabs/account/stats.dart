import 'package:flutter/material.dart';
import 'package:oneword/src/state/user.dart';
import 'package:provider/provider.dart';

class Stats extends StatelessWidget {
  Stats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user =  Provider.of<UserState>(context);

    return GridView.count(
      primary: false,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      shrinkWrap: true,
      children: [
        Stat(label: 'Honor', icon: Icons.gavel, value: 69),
        Stat(label: 'Votes', icon: Icons.whatshot, value: 420),
        Stat(label: 'Honor', icon: Icons.gavel, value: 69),
        Stat(label: 'Votes', icon: Icons.whatshot, value: 420),
        Stat(label: 'Honor', icon: Icons.gavel, value: 69),
        Stat(label: 'Votes', icon: Icons.whatshot, value: 420)
      ],
    );
  }
}

class Stat extends StatelessWidget {
  final String label;
  final IconData icon;
  final int value;

  Stat({Key key, @required this.label, @required this.icon, @required this.value }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              this.label,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
              )
            ),
            Icon(
              this.icon,
              size: 48,
            ),
            Text(
              this.value.toString(),
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
              )
            )
          ],
        ),
      ),
      onTap: () => print('$label: $value'),
    );
  }
}
