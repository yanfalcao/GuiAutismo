import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Center(
          child: Container(
            height: 300,
            width: 300,
            child: FlareActor(
              'assets/animations/PiecePluzze.flr',
              animation: 'loading',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
