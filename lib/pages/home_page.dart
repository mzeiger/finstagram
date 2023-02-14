import 'package:finstagram/pages/feed_page.dart';
import 'package:finstagram/pages/profile_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  final List<Widget> _pages = [
    FeedPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      bottomNavigationBar: _bottomNavigationBar(),
      body: _pages[_currentPage],
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: const Text(
        'Finstagram',
        style: TextStyle(fontSize: 30),
      ),
      centerTitle: true,
      actions: <Widget>[
        const SizedBox(
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            child: const Icon(Icons.add_a_photo),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            child: const Icon(Icons.logout),
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (int _index) {
          _currentPage = _index;
          setState(() {
            _currentPage = _index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Feed',
            icon: Icon(Icons.feed),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.account_box),
          ),
        ]);
  }
}
