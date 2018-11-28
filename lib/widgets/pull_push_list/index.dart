// cmdb首页
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PullPushList extends StatefulWidget {
  PullPushList({
    Key key,
    this.child,
    this.onRefresh,
  }) : super(key: key);

  final Widget child;
  final Function onRefresh;
  @override
  _PullPushListState createState() => new _PullPushListState();
}

class _PullPushListState extends State<PullPushList> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
