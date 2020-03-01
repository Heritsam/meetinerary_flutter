import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meetinerary/bloc/authentication_bloc.dart';
import 'package:meetinerary/bloc/authentication_event.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  void _signOutButtonPressed() {
    AlertDialog alertDialog = AlertDialog(
      title: Text('Sign out'),
      content: Text('Are you sure you want to sign out?'),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('No'),
          textColor: Theme.of(context).primaryColor,
        ),
        FlatButton(
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            Navigator.pop(context);
          },
          child: Text('Yes'),
          textColor: Theme.of(context).primaryColor,
        ),
      ],
    );

    showDialog(context: context, builder: (context) => alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
      ),
      body: _buildProfile(),
    );
  }

  Widget _buildProfile() {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(16.0),
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://avatars2.githubusercontent.com/u/38836505?s=460&v=4',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Ariq Heritsa',
                style: GoogleFonts.rubik(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Flutter Developer'.toUpperCase(),
                style: GoogleFonts.montserrat(
                  fontSize: 11.5,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 32.0),
        Container(
          width: MediaQuery.of(context).size.width,
          child: FlatButton(
            onPressed: _signOutButtonPressed,
            child: Text('Sign out'),
            color: Colors.red[100],
            textColor: Colors.red[700],
            padding: EdgeInsets.symmetric(vertical: 16.0),
          ),
        ),
      ],
    );
  }
}
