import 'package:flutter/material.dart';
//add import to rendering library. uncomment to debug view
//import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // uncomment this to view widget boundaries. helpful for visual debugging
    //debugPaintSizeEnabled=false;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow
      ),
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatelessWidget {

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('First Flutter App'),
      ),
      body: Container(
        child: Center(
          child: Text('This is my first flutter app. I am excited!')
        )
      ),
      );
    }
}
