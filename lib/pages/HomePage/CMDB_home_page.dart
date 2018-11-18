// CMDB主页
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../common/baseStyle.dart';

// 引入下面三个tab页面
import '../CmdbPage/index_page.dart';
import '../CmdbPage/assets_page.dart';
import '../CmdbPage/event_page.dart';

class CMDBHomePage extends StatefulWidget {
  const CMDBHomePage();

  @override
  _CMDBHomePageState createState() => _CMDBHomePageState();
}

class _CMDBHomePageState extends State<CMDBHomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context, _selectedIndex),
      body: _body(context, _selectedIndex),
      bottomNavigationBar: _bottomNavBar(context),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _bottomNavBar(BuildContext context) {
    final bottomNavBarTitleColor = const Color(0xff817F7F);
    final bottomNavBarActiveIconColor = const Color(0xff2C3144);
    final bottomNavBarIconSize = 30.0;
    return CupertinoTabBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          activeIcon: ImageIcon(
            AssetImage("assets/images/AssetMonitorHome_on.png"),
            size: bottomNavBarIconSize,
          ),
          icon: ImageIcon(
            AssetImage("assets/images/AssetMonitorHome.png"),
            size: bottomNavBarIconSize,
          ),
          title: Text(
            '首页',
            style: TextStyle(fontSize: 12, color: bottomNavBarTitleColor),
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: ImageIcon(
            AssetImage("assets/images/AssetMonitor_on.png"),
            size: bottomNavBarIconSize,
          ),
          icon: ImageIcon(
            AssetImage("assets/images/AssetMonitor.png"),
            size: bottomNavBarIconSize,
          ),
          title: Text(
            '资产/监控',
            style: TextStyle(fontSize: 12, color: bottomNavBarTitleColor),
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: ImageIcon(
            AssetImage("assets/images/AssetMonitorEvent_on.png"),
            size: bottomNavBarIconSize,
          ),
          icon: ImageIcon(
            AssetImage("assets/images/AssetMonitorEvent.png"),
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
      activeColor: bottomNavBarActiveIconColor,
    );
  }

  Widget _appbar(BuildContext context, int _selectedIndex) {
    var titleText;
    switch (_selectedIndex) {
      case 0:
        titleText = 'CMDB首页'; // cmdb首页
        break;
      case 1:
        titleText = '资产/监控'; // cmdb 资产/监控
        break;
      case 2:
        titleText = '事件中心'; // cmdb 事件
        break;
      default:
    }
    return AppBar(
      title: Center(
        child: Text(titleText,
            style: BaseStyle.appBarStyle, textAlign: TextAlign.center),
      ),
      leading: Center(
        child: IconButton(
          icon: Icon(Icons.business),
          onPressed: () {
            print('返回');
          },
        ),
      ),
      actions: <Widget>[
        Center(
          child: IconButton(
            icon: Icon(Icons.business),
            onPressed: () {
              print('搜索');
            },
          ),
        ),
      ],
      centerTitle: false, // 消除 android 与 ios 页面title布局差异
      elevation: 0.0, // 去掉appbar下面的阴影
    );
  }

  Widget _body(BuildContext context, int _selectedIndex) {
    var bodyWidget;
    switch (_selectedIndex) {
      case 0:
        bodyWidget = CMDBIndexPage(); // cmdb首页
        break;
      case 1:
        bodyWidget = CMDBAssetsPage(); // cmdb 资产/监控
        break;
      case 2:
        bodyWidget = CMDBEventPage(); // cmdb 事件
        break;
      default:
    }
    return bodyWidget;
  }
}
