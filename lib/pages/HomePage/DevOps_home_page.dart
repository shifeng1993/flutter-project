// 自动运维主页
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../common/baseStyle.dart';
import '../../widgets/index.dart';

// 引入下面三个tab页面
import '../DevOpsPage/index_page.dart';
import '../DevOpsPage/monitor_page.dart';
import '../DevOpsPage/ops_page.dart';

// 引入左侧抽屉
import '../drawerPage/home_page_left_drawer.dart';

class DevOpsHomePage extends StatefulWidget {
  const DevOpsHomePage();

  @override
  _DevOpsHomePageState createState() => _DevOpsHomePageState();
}

class _DevOpsHomePageState extends State<DevOpsHomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context, _selectedIndex),
      body: _body(context, _selectedIndex),
      bottomNavigationBar: _bottomNavBar(context),
      drawer: HomePageLeftDrawer(),
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
      title: Center(
        child: Text(
          titleText,
          style: BaseStyle.appBarStyle,
          textAlign: TextAlign.center,
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
      centerTitle: false, // 消除 android 与 ios 页面title布局差异
      elevation: 0.0, // 去掉appbar下面的阴影
    );
  }

  Widget _body(BuildContext context, int _selectedIndex) {
    var bodyWidget;
    switch (_selectedIndex) {
      case 0:
        bodyWidget = DevOpsIndexPage(); // DevOps 首页
        break;
      case 1:
        bodyWidget = DevOpsMonitorPage(); // DevOps 资产/监控
        break;
      case 2:
        bodyWidget = DevOpsOpsPage(); // DevOps 运维
        break;
      default:
    }
    return bodyWidget;
  }

  Widget _bottomNavBar(BuildContext context) {
    final bottomNavBarTitleColor = const Color(0xff817F7F);
    final bottomNavBarActiveIconColor = const Color(0xff2C3144);
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
      activeColor: bottomNavBarActiveIconColor,
    );
  }
}