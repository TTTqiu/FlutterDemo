import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShareData extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Sample Shared App Handler',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new ShareDataPage(),
    );
  }
}

class ShareDataPage extends StatefulWidget {
  ShareDataPage({Key key}) : super(key: key);

  @override
  _ShareDataPageState createState() => new _ShareDataPageState();
}

class _ShareDataPageState extends State<ShareDataPage> {
  static const platform = const MethodChannel('app.channel.shared.data');
  String dataShared = "No data";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new Expanded(
              child: new Center(
            child: new Text(dataShared),
          )),
          new FloatingActionButton(onPressed: getSharedText),
        ],
      ),
    );
  }

  getSharedText() async {
    var sharedData = await platform.invokeMethod("getSharedText");
    if (sharedData != null) {
      setState(() {
        dataShared = sharedData;
      });
    }
  }
}
