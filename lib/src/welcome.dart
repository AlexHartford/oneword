import 'package:flutter/material.dart';
import 'package:oneword/src/state/user.dart';
import 'package:provider/provider.dart';

class Welcome extends StatelessWidget {
  static const route = '/welcome';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user.toString());

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  onPressed: () => user.create(),
                  child: Text('Join Now'),
                ),
                Text(
                  'By proceeding you agree to the\nTerms of Service and Privacy Policy',
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: OutlineButton(
//                      padding: EdgeInsets.only(left: 32.0, right: 32.0),
                        onPressed: () {  },
                        child: Text('Terms of Service'),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: OutlineButton(
//                      padding: EdgeInsets.only(left: 32.0, right: 32.0),
                        onPressed: () {  },
                        child: Text('Privacy Policy'),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
