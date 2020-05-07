import 'package:flutter/material.dart';

const SECURE_ACCOUNT_BANNER_TEXT = Text(
  'Secure your account now to make it recoverable.\n\nThis does not require any information that could be used to identify you.'
);

// ignore: non_constant_identifier_names
final SECURE_ACCOUNT_DIALOG_TEXT = RichText(
  text: TextSpan(
    style: TextStyle(fontSize: 16, color: Colors.black),
    children: [
      TextSpan(
        text:
            'To preserve anonymity, Doe keeps user accounts very lightweight.\n\n'),
      TextSpan(
        text:
            'In the event you uninstall the app or something happens to your device, your account will be permanently lost - unless you finalize your account.\n\n',
        style: TextStyle(fontWeight: FontWeight.bold)),
      TextSpan(text: 'This is done by creating a username and password.  '),
      TextSpan(
        text:
            'Don\'t worry!  The username you create is for sign-in purposes only and will never be displayed or shared.',
        style: TextStyle(fontWeight: FontWeight.bold))
    ]
  )
);

// ignore: non_constant_identifier_names
final DELETE_ACCOUNT_DIALOG_TEXT = RichText(
  text: TextSpan(
    style: TextStyle(fontSize: 16, color: Colors.black),
    children: [
      TextSpan(
        text: 'Are you sure you want to delete your account?\n\n'
      ),
      TextSpan(
        text: 'This is a permanent action that cannot be undone under any circumstances.\n',
        style: TextStyle(fontWeight: FontWeight.bold)
      ),
    ]
  ),
);

const CHANGE_PASSWORD_TEXT = Text(
  'First, verify your current password.\nThen enter the new password you would like to use.',
  style: TextStyle(
    fontSize: 16
  )
);

const DELETE_ACCOUNT_TEXT = Text(
  'If you are sure you want to delete your account, please provide your password below for security.',
  style: TextStyle(
      fontSize: 16
  )
);