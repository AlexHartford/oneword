import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Input extends HookWidget {
  Input({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = useTextEditingController();

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Text message',
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(Icons.send),
            onPressed: () {},
          )
        ),
      )
    );
  }
}
