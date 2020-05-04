import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:oneword/src/state/user.dart';

class UsernameField extends HookWidget {
  final TextEditingController controller;
  final Function checkUsername;

  UsernameField({Key key, this.controller, this.checkUsername}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final unique = useState(true);
    final isValidating = useState(false);

    _checkUsername(String value) async {
      unique.value = await checkUsername(value);
    }

    _validator(String value) {
      if (value.isEmpty) return 'Please enter username';
      if (value.length < MIN_USERNAME_LENGTH) return 'Username too short';
      if (!RegExp(VALID_USERNAME_REGEX).hasMatch(value)) return 'Username cannot contain special characters';
      _checkUsername(value);
      if (!unique.value) return 'Username already taken';
      return null;
    }

    _onChanged(String text) {
      if (isValidating.value == true) return;
      if (text.length > MIN_USERNAME_LENGTH) isValidating.value = true;
      if (!RegExp(VALID_USERNAME_REGEX).hasMatch(text)) isValidating.value = true;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      child: TextFormField(
        controller: controller,
        validator: _validator,
        autovalidate: isValidating.value,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          labelText: 'Username',
          border: OutlineInputBorder()
        ),
        onChanged: _onChanged,
      ),
    );
  }
}
