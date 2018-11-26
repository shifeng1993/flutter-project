import 'package:flutter/material.dart'; // 引入是为了获取ThemeData类

@immutable
class AppState {
  // 用户信息
  final Map<String, dynamic> userInfo;

  // 全局通知列表
  final List<AppNotification<String, dynamic>> notification;

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

class AppNotification<String, T> {
  final String title;
  final String desc;
  final List<AssociatedUsers> associatedUsers;

  AppNotification(this.title, this.desc, this.associatedUsers);
}

abstract class AssociatedUsers<String, T> {
  String username;
  String age;
}
