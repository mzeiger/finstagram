import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      child: Center(child: Text('feed')),
    );
  }
}
