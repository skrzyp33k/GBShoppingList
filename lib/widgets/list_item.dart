import 'package:flutter/material.dart';

class ListItem extends StatefulWidget {
  const ListItem({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
