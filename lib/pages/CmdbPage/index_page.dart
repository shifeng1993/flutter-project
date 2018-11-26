// cmdb首页
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CMDBIndexPage extends StatefulWidget {
  CMDBIndexPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CMDBIndexPageState createState() => new _CMDBIndexPageState();
}

class _CMDBIndexPageState extends State<CMDBIndexPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffffffff), // 设置背景颜色
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width / 20,
            child: FlatButton(
              // When the user taps the button, show a snackbar
              onPressed: () {
                print(123);
              },
              child: new Container(
                padding: new EdgeInsets.all(12.0),
                child: new Text('Flat Button'),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
