// 手风琴列表控件
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flustars/flustars.dart';

import './accordion_list_item.dart';

class Action {
  final String title;
  final Function onPressed;

  Action(this.title, this.onPressed);
}

class AccordionList extends StatefulWidget {
  AccordionList(
      {Key key,
      @required this.itemBuilder,
      @required this.itemCount,
      @required this.itemMenuBuilder,
      this.padding,
      this.controller,
      this.physics})
      : super(key: key);

  final Function itemBuilder; // 子列表
  final Function itemMenuBuilder;
  final int itemCount; // 数量
  final EdgeInsets padding;
  final int controller; // 控制器
  final ScrollPhysics physics;

  @override
  _AccordionListState createState() => new _AccordionListState();
}

class _AccordionListState extends State<AccordionList> {
  int _selectIndex;

  @override
  void initState() {
    super.initState();
  }

  void setSelectIndex(int index) {
    setState(() {
      this._selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = List.generate(widget.itemCount, (int i) {
      bool isShow;
      if (_selectIndex == null) {
        isShow = false;
      } else {
        if (_selectIndex == i) {
          isShow = true;
        } else {
          isShow = false;
        }
      }
      return Builder(
        builder: (BuildContext context) {
          return AccordionListItem(
            itemBuilder: widget.itemBuilder,
            itemMenuBuilder: widget.itemMenuBuilder,
            setSelectIndex: this.setSelectIndex,
            index: i,
            isShow: isShow,
          );
        },
      );
    });
    return ListView(
      padding: widget.padding ?? EdgeInsets.only(top: 10),
      children: children,
      physics: widget.physics ?? BouncingScrollPhysics(),
    );
  }
}
