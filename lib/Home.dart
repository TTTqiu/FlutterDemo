import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myflutterapp/HttpTest.dart';

import 'AnimatedList.dart';
import 'FileIO.dart';
import 'PlatformChannelTest.dart';
import 'RandomWords.dart';

class Home extends StatefulWidget {
  @override
  _RouterSelectorState createState() => new _RouterSelectorState();
}

class _RouterSelectorState extends State<Home> {
  int index;

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _exitAppDialog,
      child: new Scaffold(
        body: Center(
          child: new ButtonBar(
            alignment: MainAxisAlignment.center,
            buttonMinWidth: 200,
            children: <Widget>[
              new RaisedButton(
                onPressed: () {
                  index = 1;
                  _routeTo();
                },
                child: new Text("1"),
              ),
              new RaisedButton(
                onPressed: () {
                  index = 2;
                  _routeTo();
                },
                child: new Text("2"),
              ),
              new RaisedButton(
                onPressed: () {
                  index = 3;
                  _routeTo();
                },
                child: new Text("3"),
              ),
              new RaisedButton(
                onPressed: () {
                  index = 4;
                  _routeTo();
                },
                child: new Text("4"),
              ),
              new RaisedButton(
                onPressed: () {
                  index = 5;
                  _routeTo();
                },
                child: new Text("5"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _routeTo() {
    switch (index) {
      case 1:
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
          return FileIO();
        }));
        break;
      case 2:
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
          return HttpTest();
        }));
        break;
      case 3:
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
          return AnimatedListSample();
        }));
        break;
      case 4:
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
          return PlatformChannel();
        }));
        break;
      case 5:
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
          return RandomWords();
        }));
        break;
      default:
        break;
    }
  }

  Future<bool> _exitAppDialog() {
    return showDialog(
        context: context,
        child: new AlertDialog(
          content: Text("Exit App?"),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("Yes")),
            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("No")),
          ],
        ));
  }
}
