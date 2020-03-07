import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meetinerary/bloc/authentication_bloc.dart';
import 'package:meetinerary/bloc/authentication_event.dart';
import 'package:meetinerary/models/profile.dart';
import 'package:meetinerary/services/api_client.dart';
import 'package:meetinerary/views/_widgets/loading_indicator_widget.dart';

import 'bloc/bloc.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<void> _handleRefresh() async {
    BlocProvider.of(context).add(FetchProfile());
    return;
  }

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
      body: BlocProvider<ProfileBloc>(
        create: (context) {
          return ProfileBloc()..add(FetchProfile());
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state is ProfileLoading) return LoadingIndicatorWidget();

            if (state is ProfileError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(state.errorMessage, style: TextStyle(
                      fontSize: 16.0
                    )),
                    SizedBox(height: 16.0),
                    RaisedButton(
                      onPressed: () {
                        BlocProvider.of<ProfileBloc>(context).add(FetchProfile());
                      },
                      child: Text('Refresh'),
                    ),
                    FlatButton(
                      onPressed: _signOutButtonPressed,
                      child: Text('Sign out'),
                      color: Colors.red[100],
                      textColor: Colors.red[700],
                    ),
                  ],
                ),
              );
            }

            if (state is ProfileLoaded) return _buildProfile(state.profile);
          },
        ),
      ),
    );
  }

  Widget _buildProfile(Profile profile) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _handleRefresh,
      child: ListView(
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
                        '${ApiClient.url}/${profile.photo}',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  profile.name.toString(),
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  profile.position.toString().toUpperCase(),
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
      ),
    );
  }
}
