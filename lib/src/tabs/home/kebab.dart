import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum Item { add, save, report }

class Kebab extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var _selection = useState(Item.add);

    return SizedBox(
      height: 25,
      width: 15,
      child: PopupMenuButton<Item>(
        onSelected: (Item result) {
          _selection.value = result;
        },
        padding: EdgeInsets.all(0),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<Item>>[
          PopupMenuItem<Item>(
            value: Item.add,
            child: Row(
              children: <Widget>[
                Icon(Icons.person_add),
                SizedBox(width: 5),
                Text('Add user'),
              ],
            ),
          ),
          PopupMenuItem<Item>(
            value: Item.save,
            child: Row(
              children: <Widget>[
                Icon(Icons.save_alt),
                SizedBox(width: 5),
                Text('Save'),
              ],
            ),
          ),
          PopupMenuItem<Item>(
            value: Item.report,
            child: Row(
              children: <Widget>[
                Icon(Icons.warning),
                SizedBox(width: 5),
                Text('Report'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
