// 自动运维主页
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:unicorndial/unicorndial.dart';
import '../../common/BaseStyle.dart';

// 引入下面三个tab页面
import '../DevOpsPage/index_page/index_page.dart';
import '../DevOpsPage/monitor_page.dart';
import '../DevOpsPage/ops_page.dart';

// 引入抽屉
import '../drawerPage/home_page_left_drawer.dart';
import '../drawerPage/assets_right_drawer.dart';

class DevOpsHomePage extends StatefulWidget {
  DevOpsHomePage({
    Key key,
    this.selectedIndex,
  }) : super(key: key);

  final int selectedIndex;

  @override
  _DevOpsHomePageState createState() => _DevOpsHomePageState();
}

class _DevOpsHomePageState extends State<DevOpsHomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.selectedIndex != null) {
      _selectedIndex = widget.selectedIndex;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _goback() {
    print('back');
    return new Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: _appbar(context, _selectedIndex),
        body: _body(context, _selectedIndex),
        bottomNavigationBar: _bottomNavBar(context),
        drawer: HomePageLeftDrawer(),
        endDrawer: _selectedIndex == 1 ? AssetsRightDrawer() : null,
        floatingActionButton: _selectedIndex == 1 ? _floatActionButton() : null,
      ),
      onWillPop: _goback,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _appbar(BuildContext context, int _selectedIndex) {
    var titleText;
    var actions;
    final iconSize = 22.0;
    switch (_selectedIndex) {
      case 0:
        titleText = 'DevOps首页'; // DevOps首页
        actions = <Widget>[
          Center(
            child: Container(
              width: iconSize + 26, // 加26是为了补齐偏差
              height: iconSize + 26, // 加26是为了补齐偏差
            ),
          ),
        ];
        break;
      case 1:
        titleText = '监控'; // 监控
        actions = <Widget>[
          IconButton(
            icon: ImageIcon(
              AssetImage("assets/icons/search_w.png"),
              size: iconSize,
            ),
            onPressed: () {
              print('搜索');
            },
          ),
          Builder(builder: (BuildContext context) {
            return IconButton(
              icon: ImageIcon(
                AssetImage("assets/icons/filter.png"),
                size: iconSize,
              ),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            );
          }),
        ];
        break;
      case 2:
        titleText = '运维'; // 运维
        actions = <Widget>[
          Center(
            child: IconButton(
              icon: ImageIcon(
                AssetImage("assets/icons/scan_w.png"),
                size: iconSize,
              ),
              onPressed: () {
                print('搜索');
              },
            ),
          ),
        ];
        break;
      default:
    }
    return AppBar(
      title: Container(
        margin: EdgeInsets.only(left: _selectedIndex == 1 ? iconSize + 20 : 0),
        child: Center(
          child: Text(
            titleText,
            style: TextStyle(fontSize: BaseStyle.fontSize[0]),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
          icon: ImageIcon(
            AssetImage("assets/icons/menu_w.png"),
            size: iconSize,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      }),
      actions: actions,
      centerTitle:
          _selectedIndex == 1 ? false : true, // 消除 android 与 ios 页面title布局差异
      elevation: 0.0, // 去掉appbar下面的阴影
    );
  }

  Function setStatusList;

  Widget _body(BuildContext context, int _selectedIndex) {
    return IndexedStack(
      children: <Widget>[
        DevOpsIndexPage(), // DevOps 首页
        DevOpsMonitorPage(onStatusList: (setStatusList) {
          this.setStatusList = setStatusList;
        }), // DevOps 资产/监控
        DevOpsOpsPage(), // DevOps 运维
      ],
      index: _selectedIndex,
    );
  }

  Widget _bottomNavBar(BuildContext context) {
    final bottomNavBarTitleColor = const Color(0xff817F7F);
    final bottomNavBarIconSize = 30.0;
    return CupertinoTabBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          activeIcon: ImageIcon(
            AssetImage("assets/icons/tabbar_home_on.png"),
            size: bottomNavBarIconSize,
          ),
          icon: ImageIcon(
            AssetImage("assets/icons/tabbar_home.png"),
            size: bottomNavBarIconSize,
          ),
          title: Text(
            '首页',
            style: TextStyle(fontSize: 12, color: bottomNavBarTitleColor),
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: ImageIcon(
            AssetImage("assets/icons/tabbar_assets_on.png"),
            size: bottomNavBarIconSize,
          ),
          icon: ImageIcon(
            AssetImage("assets/icons/tabbar_assets.png"),
            size: bottomNavBarIconSize,
          ),
          title: Text(
            '监控',
            style: TextStyle(fontSize: 12, color: bottomNavBarTitleColor),
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: ImageIcon(
            AssetImage("assets/icons/tabbar_event_on.png"),
            size: bottomNavBarIconSize,
          ),
          icon: ImageIcon(
            AssetImage("assets/icons/tabbar_event.png"),
            size: bottomNavBarIconSize,
          ),
          title: Text(
            '运维',
            style: TextStyle(fontSize: 12, color: bottomNavBarTitleColor),
          ),
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      backgroundColor: const Color(0xe6fafafa),
      activeColor: Theme.of(context).primaryColor,
    );
  }

  Widget _floatActionButton() {
    return UnicornDialer(
      orientation: UnicornOrientation.VERTICAL,
      backgroundColor: Theme.of(context).accentColor,
      parentButton: Icon(Icons.add),
      hasBackground: false, // mask
      childButtons: <UnicornButton>[
        UnicornButton(
          currentButton: FloatingActionButton(
            backgroundColor: BaseStyle.statusColor[0],
            heroTag: 'error',
            child: _getAssetStatusImage(0),
            mini: true,
            onPressed: () => setStatusList(0),
          ),
        ),
        UnicornButton(
          currentButton: FloatingActionButton(
            backgroundColor: BaseStyle.statusColor[1],
            heroTag: 'normal',
            child: _getAssetStatusImage(1),
            mini: true,
            onPressed: () => setStatusList(1),
          ),
        ),
        UnicornButton(
          currentButton: FloatingActionButton(
            backgroundColor: BaseStyle.statusColor[2],
            heroTag: 'warning',
            child: _getAssetStatusImage(2),
            mini: true,
            onPressed: () => setStatusList(2),
          ),
        ),
        UnicornButton(
          currentButton: FloatingActionButton(
            backgroundColor: Color(0xffffffff),
            heroTag: 'all',
            child: Text(
              '全部',
              style: TextStyle(
                  fontSize: BaseStyle.fontSize[4],
                  color: BaseStyle.textColor[0]),
            ),
            mini: true,
            onPressed: () => setStatusList(null),
          ),
        ),
      ],
    );
  }

  Widget _getAssetStatusImage(int status) {
    double size = 20.0;
    Widget img;
    switch (status) {
      case 0:
        img = Image.asset(
          'assets/icons/assets_status_error.png',
          width: size,
          height: size,
        );
        break;
      case 1:
        img = Image.asset(
          'assets/icons/assets_status_normal.png',
          width: size,
          height: size,
        );
        break;
      case 2:
        img = Image.asset(
          'assets/icons/assets_status_warning.png',
          width: size,
          height: size,
        );
        break;
      default:
        img = null;
    }
    return img;
  }
}
