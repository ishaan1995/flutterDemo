import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List View App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(title: 'List View App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<User>> _getData() async {
    var url = 'https://api.myjson.com/bins/c65bs';
    var response = await http.get(url);

    List<User> users = [];
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var u in jsonData) {
        User user = User.fromJson(u);
        users.add(user);
      }
    }

    print(users);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder(
            future: _getData(),
            builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
              if (asyncSnapshot.data == null) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    itemCount: asyncSnapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                asyncSnapshot.data[index].picture)),
                        title: Text(asyncSnapshot.data[index].name),
                        subtitle: Text(asyncSnapshot.data[index].email),
                      );
                    });
              }
            }),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class User {
  var name;
  var email;
  var picture;

  User(this.name, this.email, this.picture);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        picture = json['picture'];

  Map<String, dynamic> toJson() =>
      {'name': name, 'email': email, 'picture': picture};
}
