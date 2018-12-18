// cmdb首页
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PullPushList extends StatefulWidget {
  PullPushList({
    Key key,
    @required this.child,
    @required this.onRefresh,
    @required this.onLoad,
    this.onController,
    this.fontStyle,
    this.color,
  }) : super(key: key);

  final Widget child;
  final Function onRefresh;
  final Function onLoad;
  final Function onController;
  final String fontStyle;
  final Color color;

  @override
  _PullPushListState createState() => new _PullPushListState();
}

class _PullPushListState extends State<PullPushList> {
  RefreshController _controller; // 下拉刷新的控制器
  Map<String, Color> fontStyle = {
    'dark': Color(0xff000000),
    'light': Color(0xffffffff),
  };

  @override
  void initState() {
    super.initState();
    _controller = new RefreshController();
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
    if (up) {
      widget.onRefresh(_controller);
    } else {
      widget.onLoad(_controller);
    }
  }

  Widget _headerBuilder(BuildContext context, int status) {
    Color color = widget.fontStyle == null
        ? fontStyle['dark'] // 下拉刷新字体icon 默认暗色
        : fontStyle[widget.fontStyle];
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
        color: color,
      ),
      // 1对应icon
      releaseIcon: Icon(
        Icons.arrow_upward,
        color: color,
      ),
      // 2对应icon
      refreshingIcon: SpinKitDoubleBounce(
        color: color,
        size: 50.0,
      ),
      // 3对应icon
      completeIcon: Icon(
        Icons.done,
        color: color,
      ),
      // 4对应icon
      failedIcon: Icon(
        Icons.clear,
        color: color,
      ),
      // 5对应icon
      noMoreIcon: Icon(
        Icons.clear,
        color: color,
      ),

      iconPos: IconPosition.left,
      spacing: 5.0, // 间隔
      height: 60.0, // 高度
      textStyle: TextStyle(color: color), // 文字样式
    );
  }

  Widget _footerBuilder(BuildContext context, int status) {
    Color color = widget.fontStyle == null
        ? fontStyle['dark'] // 下拉刷新字体icon 默认暗色
        : fontStyle[widget.fontStyle];
    return ClassicIndicator(
      mode: status, // 传入状态

      idleText: '上拉加载', // 0对应字符串
      releaseText: '释放开始加载', // 1对应字符串
      refreshingText: '加载中...', // 2对应字符串
      completeText: '加载完成', // 3对应字符串
      failedText: '加载失败', //4对应字符串
      noDataText: '没有更多了', // 5对应字符串

      // 0对应icon
      idleIcon: Icon(
        Icons.arrow_upward,
        color: color,
      ),
      // 1对应icon
      releaseIcon: Icon(
        Icons.arrow_downward,
        color: color,
      ),
      // 2对应icon
      refreshingIcon: SpinKitDoubleBounce(
        color: color,
        size: 50.0,
      ),
      // 3对应icon
      completeIcon: Icon(
        Icons.done,
        color: color,
      ),
      // 4对应icon
      failedIcon: Icon(
        Icons.clear,
        color: color,
      ),
      // 5对应icon
      noMoreIcon: Icon(
        Icons.clear,
        color: color,
      ),

      iconPos: IconPosition.left,
      spacing: 5.0, // 间隔
      height: 60.0, // 高度
      textStyle: TextStyle(color: color), // 文字样式
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color == null ? Color(0x00000000) : widget.color,
      child: SmartRefresher(
        enablePullDown: true, // 打开下拉
        enablePullUp: true, // 打开上拉
        onRefresh: _onRefresh,
        onOffsetChange: _onOffsetCallback,
        headerBuilder: (BuildContext context, int status) {
          return _headerBuilder(context, status);
        },
        footerBuilder: (BuildContext context, int status) {
          return _footerBuilder(context, status);
        },
        headerConfig: const RefreshConfig(
          triggerDistance: 80.0,
          completeDuration: 300,
          visibleRange: 60.0,
        ),
        footerConfig: const LoadConfig(
          triggerDistance: 0,
          autoLoad: true, // 为true   triggerDistance无效
          bottomWhenBuild: true, // 是否位于底部
        ),
        controller: _controller,
        child: _list(),
      ),
    );
  }

  Widget _list() {
    new Future.delayed(const Duration(milliseconds: 1000)).then((val) {
      if (widget.onController != null) {
        widget.onController(_controller);
      }
    });
    return widget.child;
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

class FontStyle {
  static const String dark = 'dark';
  static const String light = 'light';
}
