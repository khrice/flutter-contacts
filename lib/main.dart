import 'dart:async';
import 'package:flutter/material.dart';
import './contactDetails.dart';
import './list.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = new GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Beautiful Feet',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  GoogleSignInAccount _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {

      }
    });
    _googleSignIn.signInSilently();
  }

  Future<Null> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  void _openContact() {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new CreateContact()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _openContact method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      body: _currentUser != null ? new ListDemo() : new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text("You are not currently signed in."),
          new RaisedButton(
            child: const Text('SIGN IN'),
            onPressed: _handleSignIn,
          ),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _openContact,
        tooltip: 'CreatContact',
        child: new Icon(Icons.add),
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class CreateContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ContactDetails(new Contact()),
    );
  }
}