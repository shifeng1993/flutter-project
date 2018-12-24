// 手风琴列表控件
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flustars/flustars.dart';

class Action {
  final String title;
  final Function onPressed;

  Action(this.title, this.onPressed);
}

class AccordionListItem extends StatefulWidget {
  AccordionListItem({
    Key key,
    @required this.index,
    @required this.isShow,
    @required this.itemBuilder,
    @required this.itemMenuBuilder,
    this.setSelectIndex,
    this.duration,
    this.curve,
  }) : super(key: key);

  final int index;
  final bool isShow;
  final Duration duration;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder itemMenuBuilder;
  final Function setSelectIndex;
  final Curve curve;

  @override
  _AccordionListItemState createState() => new _AccordionListItemState();
}

class _AccordionListItemState extends State<AccordionListItem> {
  double _menuHeight;

  @override
  void initState() {
    super.initState();
    _menuHeight = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print(widget.isShow);
              if (widget.isShow) {
                setState(() {
                  widget.setSelectIndex(100);
                  this._menuHeight = 0;
                });
              } else {
                setState(() {
                  widget.setSelectIndex(widget.index);
                  this._menuHeight = 300;
                });
              }
            },
            child: Builder(
              builder: (BuildContext context) {
                return widget.itemBuilder(context, widget.index);
              },
            ),
          ),
          AnimatedContainer(
            height: widget.isShow ? _menuHeight : 0, // 防止多个同时打开
            duration: widget.duration ?? Duration(milliseconds: 300),
            curve: widget.curve ?? Curves.linear,
            child: Builder(
              builder: (BuildContext context) {
                return widget.itemMenuBuilder(context, widget.index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
