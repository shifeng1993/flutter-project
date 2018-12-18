import 'dart:math';

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

  // 获取资产状态
  static int getStatus() {
    int status = Random().nextInt(3);
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
}
