import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import '../popover/popover_button.dart';
import '../triangle/index.dart';
import '../../common/baseStyle.dart';

class Action {
  final String title;
  final Function onPressed;

  Action(this.title, this.onPressed);
}

class ShadowCard extends StatefulWidget {
  ShadowCard(
      {Key key,
      this.child,
      this.margin,
      this.padding,
      this.colors,
      this.color,
      this.image,
      this.onPressed,
      this.actions})
      : super(key: key);

  final Function onPressed;
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final List<Color> colors;
  final DecorationImage image;
  final Color color;
  final List<Action> actions;

  @override
  _ShadowCardState createState() => new _ShadowCardState();
}

class _ShadowCardState extends State<ShadowCard> {
  final double rightTopButtonSize = 40.0;
  Matrix4 actionsArrow = Matrix4.identity();
  bool debounce = true; // 防止单身五百年的手速

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children =
        (widget.actions == null || widget.actions.length == 0)
            ? <Widget>[]
            : widget.actions.take(5).map((row) {
                return _action(row, widget.actions.indexOf(row));
              }).toList();
    return GestureDetector(
      onTap: widget.onPressed ?? () {},
      child: Container(
        margin: widget.margin ?? EdgeInsets.zero,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.colors ?? [Color(0xffffffff), Color(0xffffffff)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          image: widget.image,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: widget.color ?? Color(0xffffffff),
          boxShadow: <BoxShadow>[
            new BoxShadow(
              color: const Color.fromRGBO(0, 0, 0, 0.04),
              offset: new Offset(0.0, 0.0),
              blurRadius: 3.0,
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: widget.padding ?? EdgeInsets.zero,
              child: widget.child != null
                  ? Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1, // 用flex布局默认铺满宽度
                          child: widget.child,
                        ),
                      ],
                    )
                  : null,
            ),
            widget.actions == null
                ? Container(
                    width: 0,
                    height: 0,
                  )
                : Positioned(
                    right: 0,
                    top: 0,
                    width: 40,
                    height: 40,
                    child: PopoverButton(
                      button: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        child: Container(
                          width: rightTopButtonSize,
                          height: rightTopButtonSize,
                          color: Color(0x00000000),
                          child: Center(
                            child: Center(
                              child: Image.asset(
                                'assets/icons/actions.png',
                                width: 24,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(44, 49, 68, 0.8),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                              height: 30.0,
                              child: Row(
                                children: children,
                              ),
                            ),
                            Triangle(
                              direction: TriangleDirection.rightMiddle,
                              size: 10,
                              color: Color.fromRGBO(44, 49, 68, 0.8),
                              deg: 60,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _action(Action row, int index) {
    return Container(
      width: 62,
      decoration: BoxDecoration(
          border: index != 0
              ? Border(
                  left: BorderSide(
                      color: BaseStyle.lineColor[0],
                      width: 1.0 / MediaQuery.of(context).devicePixelRatio))
              : null),
      child: FlatButton(
        child: Center(
          child: Text(
            row.title,
            style: TextStyle(
              fontSize: BaseStyle.fontSize[2],
              color: Color(0xffffffff),
            ),
          ),
        ),
        onPressed: () {
          // 防止单身五百年的手速
          if (this.debounce) {
            this.debounce = false;
            row.onPressed();
            Navigator.of(context).pop();
            new Future.delayed(const Duration(milliseconds: 500)).then((val) {
              this.debounce = true;
            });
          }
        },
      ),
    );
  }
}
