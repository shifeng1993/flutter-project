import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

// 引入页面
import '../pages/index.dart';

// 容错页面
var notFoundHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  print("路由不存在！");
}); // 容错页面

// 闪屏页
var splashHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return SplashPage();
});

// CMDB首页
var cmdbHomeHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return CMDBHomePage();
});

// DevOps首页
var devOpsHomeHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return DevOpsHomePage();
});

// ITIL首页
var itilHomeHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return ITILHomePage();
});
