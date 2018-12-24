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
    @required this.listTitle,
    this.listMenu,
    this.itemHeight,
    this.setSelectIndex,
    this.duration,
    this.curve,
    this.color,
  }) : super(key: key);

  final int index;
  final bool isShow;
  final Duration duration;
  final IndexedWidgetBuilder listTitle;
  final List<Widget> listMenu;
  final double itemHeight;
  final Function setSelectIndex;
  final Curve curve;
  final Color color;

  @override
  _AccordionListItemState createState() => new _AccordionListItemState();
}

class _AccordionListItemState extends State<AccordionListItem> {
  double _menuHeight;

  @override
  void initState() {
    super.initState();
    _menuHeight = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.height);
    return Container(
      color: widget.color ?? Color(0xffffffff),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (widget.isShow) {
                setState(() {
                  widget.setSelectIndex(null); // 通过为空或者非空变换打开状态
                  this._menuHeight = 0.0;
                });
              } else {
                setState(() {
                  widget.setSelectIndex(widget.index); // 通过为空或者非空变换打开状态
                  this._menuHeight = widget.itemHeight * widget.listMenu.length;
                });
              }
            },
            child: Builder(
              builder: (BuildContext context) {
                return Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: widget.listTitle(context, widget.index),
                    ),
                    Offstage(
                      offstage: widget.listMenu == null,
                      child: Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: Transform(
                            child: Icon(
                              Icons.chevron_right,
                              color: Color(0xff000000),
                              size: 20,
                            ),
                            alignment: Alignment.center,
                            transform: new Matrix4.identity()
                              ..rotateZ(90 * 3.1415927 / 180),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          AnimatedContainer(
            height: widget.isShow ? _menuHeight : 0.0, // 防止多个同时打开
            duration: widget.duration ?? Duration(milliseconds: 300),
            curve: widget.curve ?? Curves.fastOutSlowIn,
            child: Builder(
              builder: (BuildContext context) {
                // var bounds = WidgetUtil.getWidgetBounds(context);
                // print(bounds.height);
                return ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: widget.listMenu,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
