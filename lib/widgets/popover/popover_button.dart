// cmdb首页图表
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

class PopoverButton extends StatefulWidget {
  PopoverButton({Key key, @required this.child, @required this.button})
      : super(key: key);

  final Widget button;
  final Widget child;

  @override
  _PopoverButtonState createState() => new _PopoverButtonState();
}

class _PopoverButtonState extends State<PopoverButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: widget.button ?? widget.button,
      onTap: () {
        var offset = WidgetUtil.getWidgetLocalToGlobal(context);
        // var bounds = WidgetUtil.getWidgetBounds(context);

        showGeneralDialog(
          context: context,
          pageBuilder: (BuildContext buildContext, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return Builder(builder: (BuildContext context) {
              return Container();
            });
          },
          barrierDismissible: true,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          barrierColor: Color.fromRGBO(0, 0, 0, 0.01),
          transitionDuration: const Duration(milliseconds: 200),
          transitionBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation, Widget child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      right: MediaQuery.of(context).size.width - offset.dx - 15,
                      top: offset.dy,
                      child: widget.child,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
