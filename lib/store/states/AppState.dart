import 'package:flutter/material.dart';  // 引入是为了获取ThemeData类

@immutable
class AppState {
  // 用户信息
  final Map<String, String> userInfo;

  // 全局通知列表
  final List<Map> notification;

  // 主题数据
  final ThemeData themeData;

  // 服务host
  final Map<String, String> serviceHost;

  // 构造方法
  AppState(this.userInfo, this.notification, this.themeData, this.serviceHost);

  @override
  String toString() {
    return '''AppState{
            userInfo: $userInfo,
            notification: $notification,
            themeData: $themeData,
            serviceHost: $serviceHost
        }''';
  }
}
