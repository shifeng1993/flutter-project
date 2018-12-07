// 流程主页
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../common/BaseStyle.dart';

// 引入下面三个tab页面
import '../ItilPage/index_page.dart';
import '../ItilPage/Gtasks_page.dart';
import '../ItilPage/approval_page.dart';

// 引入左侧抽屉
import '../drawerPage/home_page_left_drawer.dart';

class ITILHomePage extends StatefulWidget {
  ITILHomePage({
    Key key,
    this.selectedIndex,
  }) : super(key: key);

  final int selectedIndex;

  @override
  _ITILHomePageState createState() => _ITILHomePageState();
}

class _ITILHomePageState extends State<ITILHomePage> {
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
        titleText = 'ITIL首页'; // ITIL首页
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
        titleText = '待办'; // ITIL 待办
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
        titleText = '审批'; // ITIL 事件
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

  Widget _body(BuildContext context, int _selectedIndex) {
    return IndexedStack(
      children: <Widget>[
        ITILIndexPage(), // ITIL首页
        ITILGTasksPage(), // ITIL 待办
        ITILApprovalPage(), // ITIL 审批
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
            AssetImage("assets/icons/tabbar_gtask_on.png"),
            size: bottomNavBarIconSize,
          ),
          icon: ImageIcon(
            AssetImage("assets/icons/tabbar_gtask.png"),
            size: bottomNavBarIconSize,
          ),
          title: Text(
            '待办',
            style: TextStyle(fontSize: 12, color: bottomNavBarTitleColor),
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: ImageIcon(
            AssetImage("assets/icons/tabbar_approval_on.png"),
            size: bottomNavBarIconSize,
          ),
          icon: ImageIcon(
            AssetImage("assets/icons/tabbar_approval.png"),
            size: bottomNavBarIconSize,
          ),
          title: Text(
            '审批',
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
}
