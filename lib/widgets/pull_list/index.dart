// cmdb首页
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PullList extends StatefulWidget {
  PullList({
    Key key,
    this.child,
    this.onRefresh,
  }) : super(key: key);

  final Widget child;
  final Function onRefresh;
  @override
  _PullListState createState() => new _PullListState();
}

class _PullListState extends State<PullList> {
  RefreshController _refreshController; // 下拉刷新的控制器

  @override
  void initState() {
    super.initState();
    _refreshController = new RefreshController();
  }

  void _onOffsetCallback(bool isUp, double offset) {
    // if you want change some widgets state ,you should rewrite the callback
  }

  final Map<String, int> refreshStatus = {
    'idle': 0,
    'canRefresh': 1,
    'refreshing': 2,
    'completed': 3,
    'failed': 4,
    'noMore': 5,
  };

  void _onRefresh(bool up) {
    widget.onRefresh(_refreshController, up);
  }

  Widget _headerBuilder(BuildContext context, int status) {
    return ClassicIndicator(
      mode: status, // 传入状态

      idleText: '下拉刷新', // 0对应字符串
      releaseText: '释放开始刷新', // 1对应字符串
      refreshingText: '刷新中...', // 2对应字符串
      completeText: '刷新完成', // 3对应字符串
      failedText: '刷新失败', //4对应字符串
      noDataText: '没有数据', // 5对应字符串

      // 0对应icon
      idleIcon: Icon(
        Icons.arrow_downward,
        color: Theme.of(context).primaryColor,
      ),
      // 1对应icon
      releaseIcon: Icon(
        Icons.arrow_upward,
        color: Theme.of(context).primaryColor,
      ),
      // 2对应icon
      refreshingIcon: SpinKitDoubleBounce(
        color: Theme.of(context).primaryColor,
        size: 50.0,
      ),
      // 3对应icon
      completeIcon: Icon(
        Icons.done,
        color: Theme.of(context).primaryColor,
      ),
      // 4对应icon
      failedIcon: Icon(
        Icons.clear,
        color: Theme.of(context).primaryColor,
      ),
      // 5对应icon
      noMoreIcon: Icon(
        Icons.clear,
        color: Theme.of(context).primaryColor,
      ),

      iconPos: IconPosition.left,
      spacing: 5.0, // 间隔
      height: 60.0, // 高度
      textStyle: const TextStyle(color: const Color(0xff555555)), // 文字样式
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SmartRefresher(
        enablePullDown: true, // 打开下拉
        enablePullUp: false,
        onRefresh: _onRefresh,
        onOffsetChange: _onOffsetCallback,
        headerBuilder: (BuildContext context, int status) {
          return _headerBuilder(context, status);
        },
        headerConfig: const RefreshConfig(
          triggerDistance: 80.0,
          completeDuration: 800,
          visibleRange: 60.0,
        ),
        controller: _refreshController,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class RefreshStatus {
  static const int idle = 0;
  static const int canRefresh = 1;
  static const int refreshing = 2;
  static const int completed = 3;
  static const int failed = 4;
  static const int noMore = 5;
}