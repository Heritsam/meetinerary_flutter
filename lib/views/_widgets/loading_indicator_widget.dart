import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlareActor(
        'assets/WorldSpin.flr',
        fit: BoxFit.contain,
        animation: 'roll',
      ),
    );
  }
}

