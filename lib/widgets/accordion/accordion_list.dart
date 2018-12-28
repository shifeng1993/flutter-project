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
  AccordionList({
    Key key,
    @required this.listTitle,
    @required this.itemCount,
    @required this.listMenu,
    @required this.itemHeight,
    this.listTitlePadding,
    this.listTitleDecoration,
    this.controller,
    this.rightIconColor,
    this.rightIconSize,
    this.rightIcon,
    this.showRigtIcon = true,
  }) : super(key: key);

  final Function listTitle; // 子列表
  final Function listMenu;
  final int itemCount; // 数量
  final Function itemHeight; // menuitem高度
  final int controller; // 控制器
  final EdgeInsets listTitlePadding;
  final BoxDecoration listTitleDecoration;
  final Color rightIconColor;
  final double rightIconSize;
  final Widget rightIcon;
  final bool showRigtIcon;

  @override
  _AccordionListState createState() => new _AccordionListState();
}

class _AccordionListState extends State<AccordionList> {
  var _selectIndex;

  @override
  void initState() {
    super.initState();
  }

  void setSelectIndex(var index) {
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
            listTitle: widget.listTitle,
            listMenu: widget.listMenu,
            itemHeight: widget.itemHeight(context, i),
            setSelectIndex: this.setSelectIndex,
            listTitlePadding: widget.listTitlePadding ?? EdgeInsets.zero,
            listTitleDecoration: widget.listTitleDecoration,
            rightIconColor: widget.rightIconColor,
            rightIconSize: widget.rightIconSize,
            rightIcon: widget.rightIcon,
            showRigtIcon: widget.showRigtIcon,
            index: i,
            isShow: isShow,
          );
        },
      );
    });
    return Column(
      children: children,
    );
  }
}
