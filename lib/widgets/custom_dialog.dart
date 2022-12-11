import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  CustomDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.actions});

  Text title = Text('title');
  Text content = Text('content');
  List<Widget> actions = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: actions,
    );
  }
}
