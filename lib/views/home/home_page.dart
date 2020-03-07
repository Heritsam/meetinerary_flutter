import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meetinerary/views/meeting/meeting_page.dart';
import 'package:meetinerary/views/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentPage,
        children: <Widget>[
          MeetingPage(),
          Text('nahloh'),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: CubertoBottomBar(
        tabStyle: CubertoTabStyle.STYLE_FADED_BACKGROUND,
        selectedTab: _currentPage,
        tabs: [
          TabData(
            iconData: Icons.check_box_outline_blank,
            title: "Meetings",
          ),
          TabData(
            iconData: Icons.add_circle_outline,
            title: "Created Meeting",
          ),
          TabData(
            iconData: Icons.person_outline,
            title: "Profile",
          ),
        ],
        onTabChangedListener: (int position, String title, Color tabColor) {
          setState(() {
            _currentPage = position;
          });
        },
      ),
    );
  }
}
