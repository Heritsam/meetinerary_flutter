import 'package:flutter/material.dart';

class MeetingPage extends StatefulWidget {
  @override
  _MeetingPageState createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Meetings'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.history),
            tooltip: 'History',
          )
        ],
      ),
    );
  }
}
