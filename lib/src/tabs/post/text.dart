import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:oneword/src/state/feed.dart';

class TextPost extends HookWidget {
  static const route = '/post/text';

  TextPost({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feed = Provider.of<Feed>(context);

    final _controller = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Text post'),
        leading: CloseButton()
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'What\'s up?',
              border: InputBorder.none
            ),
            maxLines: 500,
            keyboardType: TextInputType.multiline
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: () async {
          if (_controller.text.isEmpty) return;
          await feed.addTextPost(_controller.text);
          Navigator.pop(context);
        }
      ),
    );
  }
}
