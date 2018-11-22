// 三个homepage的抽屉
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../HomePage/CMDB_home_page.dart';
import '../HomePage/DevOps_home_page.dart';
import '../HomePage/ITIL_home_page.dart';

import '../../store/states/AppState.dart';

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
          color: const Color(0xff2C3144),
          child: Stack(
            children: <Widget>[
              ListView(
                padding: EdgeInsets.only(top: 20.0),
                children: <Widget>[
                  _drawerHeader(context, userInfo),
                  ListTile(
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
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, _, __) {
                            return CMDBHomePage();
                          },
                          transitionDuration: const Duration(milliseconds: 300),
                          transitionsBuilder: (_, animation, __, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: FadeTransition(
                                opacity: Tween(begin: 0.5, end: 1.0)
                                    .animate(animation),
                                child: child,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  ListTile(
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
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, _, __) {
                            return DevOpsHomePage();
                          },
                          transitionDuration: const Duration(milliseconds: 300),
                          transitionsBuilder: (_, animation, __, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: FadeTransition(
                                opacity: Tween(begin: 0.5, end: 1.0)
                                    .animate(animation),
                                child: child,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  ListTile(
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
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, _, __) {
                            return ITILHomePage();
                          },
                          transitionDuration: const Duration(milliseconds: 300),
                          transitionsBuilder: (_, animation, __, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: FadeTransition(
                                opacity: Tween(begin: 0.5, end: 1.0)
                                    .animate(animation),
                                child: child,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  )
                ],
              ),
              Positioned(
                child: new Container(
                  child: new Text(
                    "这里是设置或者更换皮肤按钮的预留区域dsadsad",
                  ),
                  decoration: new BoxDecoration(
                    color: Colors.red[400],
                  ),
                  padding: new EdgeInsets.all(16.0),
                ),
                bottom: 0.0,
              ),
            ],
          )),
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
            child: Text('超'),
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
}
