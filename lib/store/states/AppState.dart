import 'package:flutter/material.dart'; // 引入是为了获取ThemeData类

@immutable
class AppState {
  // 用户信息
  final Map<String, dynamic> userInfo;

  // 全局通知列表
  final List<AppNotification> notification;

  // 主题数据
  final ThemeData themeData;

  // 服务host
  final Map<String, dynamic> serviceHost;

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

class AppNotification {
  final String title;
  final String desc;

  AppNotification(this.title, this.desc);
}
