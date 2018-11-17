import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

// 引入页面
import '../pages/index.dart';

var splashHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return SplashPage();
});

var homeHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return HomePage();
});
