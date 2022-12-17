import 'package:flutter/material.dart';

class ListInfoPage extends StatefulWidget {
  const ListInfoPage({Key? key, required this.isTrashed}) : super(key: key);

  final bool isTrashed;

  @override
  State<ListInfoPage> createState() => _ListInfoPageState();
}

class _ListInfoPageState extends State<ListInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
