import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const MIN_PASSWORD_LENGTH = 8;

class PasswordField extends HookWidget {
  final TextEditingController controller;
  final String labelText;
  final validator;

  PasswordField({Key key, @required this.controller, this.labelText, this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final obscureText = useState(false);
    final isValidating = useState(false);

    _validator(String value) {
      if (value.isEmpty) return 'Please enter password';
      if (value.length < MIN_PASSWORD_LENGTH) return 'Password too short';
      return null;
    }

    _onChanged(String text) {
      if (isValidating.value == true) return;
      if (text.length > MIN_PASSWORD_LENGTH) isValidating.value = true;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      child: TextFormField(
        controller: controller,
        validator: validator ?? _validator,
        autovalidate: isValidating.value,
        obscureText: obscureText.value,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          labelText: labelText ?? 'Password',
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: obscureText.value ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
            onPressed: () => obscureText.value = !obscureText.value,
          )
        ),
        onChanged: _onChanged,
      ),
    );
  }
}
