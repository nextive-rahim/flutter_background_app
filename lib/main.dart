import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background/app_retain_widget.dart';

void backgroundMain() {
  WidgetsFlutterBinding.ensureInitialized();
}

void main() {
  runApp(MyApp());

  var channel = const MethodChannel('com.app/background_service');
  var callbackHandle = PluginUtilities.getCallbackHandle(backgroundMain);
  channel.invokeMethod('startService', callbackHandle!.toRawHandle());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Background Demo',
      home: AppRetainWidget(
        child: MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

///

class _MyWidgetState extends State<MyWidget> {
  int _counter = 0;
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter++;
      });
      print('Counter incrementeds: $_counter');
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Background Processing'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          _counter.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
