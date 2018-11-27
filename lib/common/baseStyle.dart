import 'package:flutter/material.dart';

class BaseStyle {
  static final List<dynamic> fontSize = [
    18.0, // 顶部一级标题
    15.0, // 导航栏/卡片标题/列表文字/按钮文字
    14.0, // 二级正文内容
    13.0, // 卡片正文内容
    12.0, // 日期等辅助性文字
  ];

  /* 文字颜色  */
  static final List<Color> textColor = [
    const Color(0xff303133),
    const Color(0xff606266),
    const Color(0xff909399),
  ];

  // 分割线颜色
  static final List<Color> lineColor = [
    const Color(0xffE4E7ED),
  ];
}
