// CMDB主页
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../common/BaseStyle.dart';

// 引入下面三个tab页面
import '../CmdbPage/index_page/index_page.dart';
import '../CmdbPage/assets_page/assets_page.dart';
import '../CmdbPage/event_page.dart';

// 引入左侧抽屉
import '../drawerPage/home_page_left_drawer.dart';

class CMDBHomePage extends StatefulWidget {
  CMDBHomePage({
    Key key,
    this.selectedIndex,
  }) : super(key: key);

  final int selectedIndex;

  @override
  _CMDBHomePageState createState() => _CMDBHomePageState();
}

class _CMDBHomePageState extends State<CMDBHomePage> {
  BuildContext context;
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
    this.context = context;
    return WillPopScope(
      child: Scaffold(
        appBar: _appbar(_selectedIndex),
        body: _body(_selectedIndex),
        bottomNavigationBar: _bottomNavBar(),
        drawer: HomePageLeftDrawer(),
      ),
      onWillPop: _goback,
    );
  }

  Widget _appbar(int _selectedIndex) {
    var titleText;
    var actions;
    final iconSize = 22.0;
    switch (_selectedIndex) {
      case 0:
        titleText = 'CMDB首页'; // cmdb首页
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
        titleText = '资产/监控'; // cmdb 资产/监控
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
        titleText = '事件中心'; // cmdb 事件
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
          style: TextStyle(fontSize: BaseStyle.fontSize[0]),
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
      centerTitle: true, // 消除 android 与 ios 页面title布局差异
      elevation: 0.0, // 去掉appbar下面的阴影
    );
  }

  Widget _body(int _selectedIndex) {
    return IndexedStack(
      children: <Widget>[
        CMDBIndexPage(), // cmdb首页
        CMDBAssetsPage(), // cmdb 资产/监控
        CMDBEventPage(), // cmdb 事件
      ],
      index: _selectedIndex,
    );
  }

  Widget _bottomNavBar() {
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
            '资产/监控',
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
            '事件',
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
