import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meetinerary/views/_widgets/loading_indicator_widget.dart';
import 'package:meetinerary/views/meeting/bloc/bloc.dart';
import 'package:time_formatter/time_formatter.dart';

class MeetingPage extends StatefulWidget {
  @override
  _MeetingPageState createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> {
  GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

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
      body: BlocProvider<MeetingBloc>(
        create: (context) {
          return MeetingBloc()..add(FetchMeeting());
        },
        child: BlocBuilder<MeetingBloc, MeetingState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state is MeetingLoaded) {
              return RefreshIndicator(
                key: _refreshKey,
                onRefresh: () async {
                  BlocProvider.of<MeetingBloc>(context).add(FetchMeeting());
                },
                child: ListView.builder(
                  padding: EdgeInsets.all(16.0),
                  itemCount: state.meetings.length,
                  itemBuilder: (context, position) {
                    return _buildListCard(
                      state.meetings[position].title.toString(),
                      state.meetings[position].datetime.millisecondsSinceEpoch,
                      position
                    );
                  },
                ),
              );
            }

            if (state is MeetingLoading) {
              return InkWell(
                onDoubleTap: () => BlocProvider.of<MeetingBloc>(context).add(FetchMeeting()),
                child: LoadingIndicatorWidget()
              );
            }

            if (state is MeetingError) {
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
                        BlocProvider.of<MeetingBloc>(context).add(FetchMeeting());
                      },
                      child: Text('Refresh'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildListCard(String title, int datetime, int position) {
    String _formattedTime = formatTime(datetime);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 4.0,
            ),
          ),
        ),
        child: ListTile(
          onTap: () => print('wayoo'),
          title: Text(
            title.toString(),
            style: GoogleFonts.rubik(
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Text(
            _formattedTime,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          trailing: IconButton(
            onPressed: null,
            icon: Icon(Icons.chevron_right),
          ),
        ),
      ),
    );
  }
}
