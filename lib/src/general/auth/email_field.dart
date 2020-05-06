import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import 'package:oneword/src/state/user.dart';

class EmailField extends HookWidget {
  final TextEditingController controller;

  EmailField({Key key, @required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);

    final unique = useState(true);

    _checkEmail(String value) async {
      unique.value = await user.checkEmail(value);
    }

    _validator(String value) {
      if (value.isEmpty) return 'Please enter email';
      if (!value.contains('.') || !value.contains('@')) return 'Invalid email';
      if (!value.contains('@')) return 'Invalid email';

      _checkEmail(value);
      if (unique.value == null) return 'Invalid email';
      if (!unique.value) return 'Email already in use';
      return null;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      child: TextFormField(
        autofocus: true,
        controller: controller,
        validator: _validator,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          labelText: 'Email',
          border: OutlineInputBorder()
        ),
      ),
    );
  }
}
