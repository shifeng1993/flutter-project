import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../common/baseStyle.dart';

class Action {
  Action({this.title, this.onPressed, this.backgroundColor});

  final Widget title;
  final Function onPressed;
  final Color backgroundColor;
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
  final SlidableController slidableController = new SlidableController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool hasActions = (widget.actions == null || widget.actions.length == 0);
    List<Widget> actionsWidget = hasActions
        ? <Widget>[]
        : widget.actions.take(5).map((row) {
            return _action(row, widget.actions.indexOf(row));
          }).toList();
    return Container(
      margin: widget.margin ?? EdgeInsets.zero,
      child: hasActions
          ? _card()
          : Slidable(
              key: widget.key,
              delegate: SlidableBehindDelegate(),
              actionExtentRatio: 0.15,
              controller: slidableController,
              secondaryActions: actionsWidget,
              child: _card(),
            ),
    );
  }

  Widget _card() {
    return GestureDetector(
      onTap: () {
        if (widget.onPressed != null) {
          widget.onPressed();
        }
        if (slidableController.activeState != null) {
          slidableController.activeState.close();
        }
      },
      child: Container(
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
          ],
        ),
      ),
    );
  }

  Widget _action(Action row, int index) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.centerRight,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(40 / 2)),
            child: Material(
              color: row.backgroundColor ?? Color(0x00000000),
              child: InkWell(
                onTap: () {
                  // 防止单身五百年的手速
                  if (this.debounce) {
                    this.debounce = false;
                    row.onPressed();
                    slidableController.activeState.close();
                    new Future.delayed(const Duration(milliseconds: 500))
                        .then((val) {
                      this.debounce = true;
                    });
                  }
                },
                highlightColor: Color.fromRGBO(0, 0, 0, 0.04),
                splashColor: Color.fromRGBO(0, 0, 0, 0.08),
                child: Container(
                  width: 40,
                  height: 40,
                  child: row.title ?? null,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
