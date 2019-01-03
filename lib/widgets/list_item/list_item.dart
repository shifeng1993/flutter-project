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

class ListItem extends StatefulWidget {
  ListItem({
    Key key,
    this.isShow,
    this.listTitle,
    this.listMenu,
    this.listMenuHeight,
    this.duration,
    this.curve,
    this.listTitlePadding,
    this.listTitleDecoration,
    this.rightIconColor,
    this.rightIconSize,
    this.rightIcon,
    this.showRigtIcon,
  }) : super(key: key);

  final bool isShow;
  final Duration duration;
  final Function listTitle;
  final Function listMenu;
  final double listMenuHeight;
  final Curve curve;
  final EdgeInsets listTitlePadding;
  final BoxDecoration listTitleDecoration;
  final Color rightIconColor;
  final double rightIconSize;
  final Widget rightIcon;
  final bool showRigtIcon;

  @override
  _ListItemState createState() => new _ListItemState();
}

class _ListItemState extends State<ListItem>
    with SingleTickerProviderStateMixin {
  double _menuHeight;
  AnimationController _animationController;
  Animation<double> _animation;
  bool _isShow;

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
    _isShow = widget.isShow ?? false;
  }

  @override
  dispose() {
    this._animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.height);
    Widget listmenu;
    _animationController.reverse();
    if (_isShow) {
      _animationController.forward();
    }
    if (widget.listMenu != null) {
      listmenu = widget.listMenu(context);
    }
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (_isShow) {
                setState(() {
                  _isShow = false;
                  this._menuHeight = 0.0;
                  _animationController.reverse();
                });
              } else {
                setState(() {
                  _isShow = true;
                  this._menuHeight = widget.listMenuHeight;
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
                        child: widget.listTitle(context),
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
                                  ..rotateZ((widget.listMenuHeight == null
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
          widget.listMenu != null
              ? AnimatedContainer(
                  height: _isShow ? _menuHeight : 0.0, // 防止多个同时打开
                  duration: widget.duration ?? Duration(milliseconds: 300),
                  curve: widget.curve ?? Curves.fastOutSlowIn,
                  child: listmenu,
                )
              : Container(),
        ],
      ),
    );
  }
}
