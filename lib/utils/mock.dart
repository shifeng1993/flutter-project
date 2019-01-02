import 'dart:math';
import 'package:flutter/material.dart';
import '../common/baseStyle.dart';

abstract class Mock {
  List<String> system = ['windows', 'centos', 'ubuntu', 'macos'];
  // 获取IP
  static String getIP() {
    return '${Random().nextInt(255).toString()}.${Random().nextInt(255).toString()}.${Random().nextInt(255).toString()}.${Random().nextInt(255).toString()}';
  }

  // 获取资产类型
  static String getCiType() {
    List<String> system = ['windows', 'centos', 'ubuntu', 'macos'];
    return system[Random().nextInt(4)];
  }

  // 获取状态
  static int getStatus({int max: 3}) {
    int status = Random().nextInt(max);
    return status;
  }

  // 获取资产状态文字
  static String getStatusText() {
    int status = Random().nextInt(3);
    String statusText;
    switch (status) {
      case 0:
        statusText = '宕机';
        break;
      case 1:
        statusText = '正常';
        break;
      case 2:
        statusText = '告警';
        break;
      default:
        statusText = '未知';
    }
    return statusText;
  }

  // 获取随机日期时间
  static String getDateTime() {
    int base = 2000;
    int year = base + Random().nextInt(18);
    int month = Random().nextInt(12);
    int day = Random().nextInt(31);
    int hour = Random().nextInt(24);
    int minute = Random().nextInt(60);
    int second = Random().nextInt(60);
    DateTime dateTime = new DateTime(year, month, day, hour, minute, second);

    return dateTime.toString().split('.')[0];
  }

  // 获取0 -100的随机打分
  static String getScore() {
    int scoreMax = Random().nextInt(101);
    String score;
    if (scoreMax == 100) {
      score = scoreMax.toDouble().toStringAsFixed(1);
    } else {
      score =
          (scoreMax.toDouble() + new Random().nextDouble()).toStringAsFixed(1);
    }
    return score;
  }

  static String getAssetStatus(int status) {
    String statusText;
    switch (status) {
      case 0:
        statusText = '宕机';
        break;
      case 1:
        statusText = '正常';
        break;
      case 2:
        statusText = '告警';
        break;
      default:
        statusText = '未知';
    }
    return statusText;
  }

  static List<int> getWeightList({int length}) {
    List<int> list = [];

    length = length == null
        ? 3 + Random().nextInt(8)
        : length; // 如果有参length则循环length，没有则循环3-10随机次数

    int sum(List<int> list) {
      int total = 0;
      for (var j = 0; j < list.length; j++) {
        total += list[j];
      }
      return total;
    }

    list.addAll(List.generate(length - 1, (i) {
      return Random().nextInt(100) + 1; // 返回1-100的整数
    }));

    int numSum = sum(list);
    if (numSum < 100) {
      // 如果除最后一项外的所有项综合小于1，则补全最后一项，输出list
      list.add(100 - numSum);
      return list;
    } else {
      // 如果大于或者等于1，先算多出1.0的值，然后进行四舍五入取整,取出倍数再用数组的每一项除这个倍数
      int multiple = ((numSum - 100) / 100).ceil() + 1;
      List<int> newlist = [];
      newlist.addAll(List.generate(length - 1, (i) {
        var item = list[i] / multiple;
        return item.toInt();
      }));
      // 最后给新的list 补全最后一项
      newlist.add(100 - sum(newlist));
      return newlist;
    }
  }
}
