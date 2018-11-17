// Home
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: _body(context),
    );
  }

  Widget _appbar(BuildContext context) {
    return AppBar(
      title: Container(
        child: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.transparent,
          tabs: const <Tab>[
            const Tab(text: '我的'),
            const Tab(text: '发现'),
            const Tab(text: '视频'),
          ],
        ),
      ),
      leading: Center(
        child: Text('菜单'),
      ),
      actions: <Widget>[
        Center(
          child: Text('搜索'),
        )
      ],
      centerTitle: true, // 消除 android 与 ios 页面title布局差异
      elevation: 0.0, // 去掉appbar下面的阴影
    );
  }

  Widget _body(BuildContext context) {
    return Center(
      child: Text('主页'),
    );
  }
}
