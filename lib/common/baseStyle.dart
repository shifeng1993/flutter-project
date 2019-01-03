import 'package:flutter/material.dart';

abstract class BaseStyle {
  static final List<dynamic> fontSize = [
    18.0, // 顶部一级标题
    15.0, // 导航栏/卡片标题/列表文字/按钮文字
    14.0, // 二级正文内容
    13.0, // 卡片正文内容
    12.0, // 日期等辅助性文字
    11.0, // 日期等辅助性文字
  ];

  /* 文字颜色  */
  static final List<Color> textColor = [
    const Color(0xff303133),
    const Color(0xff606266),
    const Color(0xff909399),
  ];

  /* 状态颜色  */
  static final List<Color> statusColor = [
    const Color(0xffff6263), // error
    const Color(0xff67c23b), // success
    const Color(0xffffc036), // warning
    const Color(0xffF0F2F5), // 未知
  ];

  // 分割线颜色
  static final List<Color> lineColor = [
    const Color(0xffE4E7ED),
  ];

  static double pixelWidth(BuildContext context, double pixel) {
    return pixel / MediaQuery.of(context).devicePixelRatio;
  }
}
