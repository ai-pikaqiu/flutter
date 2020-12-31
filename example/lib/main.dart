import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geolocator/flutter_geolocator.dart';
import 'package:flutter_geolocator/models/position.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterGeolocator _geolocator = new FlutterGeolocator();
  Position _position;
  StreamSubscription<Position> _positionSubscription;

  @override
  initState() {
    super.initState();
    initPlatformState();

    _positionSubscription =
        _geolocator.onPositionChanged.listen((Position position) {
          setState(() {
            _position = position;
          });
        });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    Position position;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      position = await _geolocator.getPosition;
    } on PlatformException {
      position = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted)
      return;

    setState(() {
      _position = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    final position = _position == null ? 'Unknown' : _position.latitude.toString() + ', ' + _position.longitude.toString();

    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Plugin example app'),
        ),
        body: new Center(
          child: new Text('Current location: $position\n'),
        ),
      ),
    );
  }
}
