// 手风琴列表控件
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:core';
import 'dart:math' as Math;

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
    this.listTitlePadding,
    this.listTitleDecoration,
    this.rightIconColor,
    this.rightIconSize,
    this.rightIcon,
    this.showRigtIcon,
  }) : super(key: key);

  final int index;
  final bool isShow;
  final Duration duration;
  final IndexedWidgetBuilder listTitle;
  final IndexedWidgetBuilder listMenu;
  final double itemHeight;
  final Function setSelectIndex;
  final Curve curve;
  final EdgeInsets listTitlePadding;
  final BoxDecoration listTitleDecoration;
  final Color rightIconColor;
  final double rightIconSize;
  final Widget rightIcon;
  final bool showRigtIcon;

  @override
  _AccordionListItemState createState() => new _AccordionListItemState();
}

class _AccordionListItemState extends State<AccordionListItem>
    with SingleTickerProviderStateMixin {
  double _menuHeight;
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _menuHeight = 0.0;
    _animationController = AnimationController(
      duration: widget.duration ?? Duration(milliseconds: 200),
      vsync: this,
    );
    // 从0度旋转到90度
    _animation = new Tween(begin: 0.0, end: 90.0).animate(_animationController);
  }

  @override
  dispose() {
    this._animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.height);
    _animationController.reverse();
    if (widget.isShow) {
      _animationController.forward();
    }
    Widget listmenu = widget.listMenu(context, widget.index);
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (widget.isShow) {
                setState(() {
                  widget.setSelectIndex(null); // 通过为空或者非空变换打开状态
                  this._menuHeight = 0.0;
                  _animationController.reverse();
                });
              } else {
                setState(() {
                  widget.setSelectIndex(widget.index); // 通过为空或者非空变换打开状态
                  this._menuHeight = widget.itemHeight;
                  _animationController.forward();
                });
              }
            },
            child: Builder(
              builder: (BuildContext context) {
                return Container(
                  decoration: widget.listTitleDecoration,
                  padding: widget.listTitlePadding,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: widget.listTitle(context, widget.index),
                      ),
                      Offstage(
                        offstage: !widget.showRigtIcon,
                        child: Center(
                          child: AnimatedBuilder(
                            animation: _animationController,
                            builder: (BuildContext context, Widget child) {
                              return Transform(
                                child: widget.rightIcon ??
                                    Icon(
                                      Icons.chevron_right,
                                      color: widget.rightIconColor ??
                                          Color(0xff000000),
                                      size: widget.rightIconSize ?? 20.0,
                                    ),
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..rotateZ((widget.itemHeight == 0.0
                                          ? 0.0
                                          : _animation.value) *
                                      Math.pi /
                                      180),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          AnimatedContainer(
            height: widget.isShow ? _menuHeight : 0.0, // 防止多个同时打开
            duration: widget.duration ?? Duration(milliseconds: 300),
            curve: widget.curve ?? Curves.fastOutSlowIn,
            child: listmenu,
          ),
        ],
      ),
    );
  }
}
