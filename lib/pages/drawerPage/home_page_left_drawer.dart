// 三个homepage的抽屉
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../HomePage/CMDB_home_page.dart';
import '../HomePage/DevOps_home_page.dart';
import '../HomePage/ITIL_home_page.dart';

import '../../store/states/AppState.dart';
import '../../widgets/page_route_Builder/index.dart';

class HomePageLeftDrawer extends StatelessWidget {
  final iconSize = 24.0;
  final textSize = 15.0;

  final Duration transitionDuration = Duration(seconds: 2);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map<String, dynamic>>(
      builder: (BuildContext context, userInfo) {
        return _drawer(context, userInfo);
      },
      converter: (store) => store.state.userInfo,
    );
  }

  Widget _drawer(BuildContext context, Map<String, dynamic> userInfo) {
    return Drawer(
      elevation: 0.0, // 去掉阴影
      semanticLabel: '123',
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Stack(
          children: <Widget>[
            ListView(
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.only(top: 20.0),
              children: <Widget>[
                _drawerHeader(context, userInfo),
                FlatButton(
                  padding: EdgeInsets.zero,
                  child: ListTile(
                    leading: ImageIcon(
                      AssetImage("assets/icons/left_drawer_cmdb.png"),
                      size: iconSize,
                      color: Color(0xffffffff),
                    ),
                    title: Text(
                      '资产监控',
                      style: TextStyle(
                        color: const Color(0xffffffff),
                        fontSize: textSize,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      RouteBuilder.fadePage(CMDBHomePage()),
                    );
                  },
                ),
                FlatButton(
                  padding: EdgeInsets.zero,
                  child: ListTile(
                    leading: ImageIcon(
                      AssetImage("assets/icons/left_drawer_ops.png"),
                      size: iconSize,
                      color: Color(0xffffffff),
                    ),
                    title: Text(
                      '运维中心',
                      style: TextStyle(
                        color: const Color(0xffffffff),
                        fontSize: textSize,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      RouteBuilder.fadePage(DevOpsHomePage(
                        selectedIndex: 0,
                      )),
                    );
                  },
                ),
                FlatButton(
                  padding: EdgeInsets.zero,
                  child: ListTile(
                    leading: ImageIcon(
                      AssetImage("assets/icons/left_drawer_itil.png"),
                      size: iconSize,
                      color: Color(0xffffffff),
                    ),
                    title: Text(
                      '流程中心',
                      style: TextStyle(
                        color: const Color(0xffffffff),
                        fontSize: textSize,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      RouteBuilder.fadePage(ITILHomePage()),
                    );
                  },
                ),
              ],
            ),
            _bottomButton(context),
          ],
        ),
      ),
    );
  }

  Widget _drawerHeader(BuildContext context, Map<String, dynamic> userInfo) {
    return UserAccountsDrawerHeader(
      accountName: GestureDetector(
        onTap: () {
          print(userInfo['name']);
        },
        child: Text(userInfo['name']),
      ),
      accountEmail: GestureDetector(
        onTap: () {
          print('个人信息');
        },
        child: Text(userInfo['org']),
      ),
      decoration: BoxDecoration(
        color: const Color(0x00000000),
        image: DecorationImage(
          image: AssetImage('assets/images/drawer_navigator_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      currentAccountPicture: GestureDetector(
        onTap: () {
          print(userInfo['name']);
        },
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/images/user_default.png'),
        ),
      ),
      otherAccountsPictures: <Widget>[
        CircleAvatar(
          child: Center(
            child: Text('资'),
          ),
        ),
        CircleAvatar(
          child: Center(
            child: Text('流'),
          ),
        ),
      ],
      // onDetailsPressed: () {},
    );
  }

  Widget _bottomButton(BuildContext context) {
    return Positioned(
      child: SafeArea(
        bottom: true,
        child: Container(
          color: Theme.of(context).primaryColor,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(60 / 2)),
                child: Material(
                  color: Color(0x00000000),
                  child: InkWell(
                    onTap: () {
                      print('设置');
                    },
                    highlightColor: Theme.of(context).highlightColor,
                    splashColor: Theme.of(context).splashColor,
                    child: Container(
                      width: 60,
                      height: 60,
                      child: Center(
                          child: Image(
                        image: AssetImage('assets/icons/button_setting.png'),
                        width: 24.0,
                        height: 24.0,
                      )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottom: 0.0,
    );
  }
}
