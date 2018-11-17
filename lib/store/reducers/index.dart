/* ******************* 以下是redux dart版本文档关键 开始 ******************* */
/// combineReducers在Dart中的工作方式与在JS中的工作方式略有不同。
/// redux.js有一个工具函数，可以方便地将一组State键与给定的reducer合并。不幸的是，这在Dart上效果不是很好！
/// 因为 Dart非常适合在强类型检查下工作，这意味着可以在代码编辑器中为重构和更好的提示获得一些出色的工具支持
/// 那么我们如何组成大型状态树？ 答案是：简单的函数组合！
/* ******************* 以下是redux dart版本文档关键 结束 ******************* */

import 'package:flutter/material.dart'; // 引入是为了获取ThemeData类
import 'package:redux/redux.dart';
import '../states/AppState.dart';
import '../actions/index.dart';

/* ******************* 服务host 开始 ******************* */
// 设置服务host函数
Map<String,String> setUserInfoAction(Map<String,String> userInfo, SetUserInfoAction action) {
  return userInfo;
}

// 合并服务host相关函数
Reducer<Map<String,String>> userInfoReducer = combineReducers<Map<String,String>>([
  new TypedReducer<Map<String,String>, SetUserInfoAction>(setUserInfoAction),
]);


/* ******************* 全局通知 开始 ******************* */
// 设置全局通知函数
List<Map> setNotificationAction(List<Map> notification, SetNotificationAction action) {
  return notification;
}

// 合并全局通知相关函数
Reducer<List<Map>> notificationReducer = combineReducers<List<Map>>([
  new TypedReducer<List<Map>, SetNotificationAction>(setNotificationAction),
]);


/* ******************* 主题数据 开始 ******************* */
// 设置主题数据函数
ThemeData setThemeDataAction(ThemeData themeData, SetThemeDataAction action) {
  return themeData;
}

// 合并主题数据相关函数
Reducer<ThemeData> themeDataReducer = combineReducers<ThemeData>([
  new TypedReducer<ThemeData, SetThemeDataAction>(setThemeDataAction),
]);


/* ******************* 服务host 开始 ******************* */
// 设置服务host函数
Map<String,String> setServiceHostAction(Map<String,String> serviceHost, SetServiceHostAction action) {
  return serviceHost;
}

// 合并服务host相关函数
Reducer<Map<String,String>> serviceHostReducer = combineReducers<Map<String,String>>([
  new TypedReducer<Map<String,String>, SetServiceHostAction>(setServiceHostAction),
]);


// 获取总的reducer
AppState appReducer(AppState state, action) => new AppState(
      userInfoReducer(state.userInfo, action),
      notificationReducer(state.notification, action),
      themeDataReducer(state.themeData, action),
      serviceHostReducer(state.serviceHost, action),
);
