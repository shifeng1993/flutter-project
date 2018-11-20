// 三个homepage的抽屉
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../routes/AppNavigator.dart';

class HomePageLeftDrawer extends StatelessWidget {
  final iconSize = 24.0;
  final textSize = 15.0;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0, // 去掉阴影
      semanticLabel: '123',
      child: Container(
        color: const Color(0xff2C3144),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
              ),
              child: Center(
                child: SizedBox(
                  width: 60.0,
                  height: 60.0,
                  child: CircleAvatar(
                    child: Text('R'),
                  ),
                ),
              ),
            ),
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
              selected: true,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/cmdbHome', ModalRoute.withName('/'));
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
                Navigator.pushNamedAndRemoveUntil(
                    context, '/devOpsHome', ModalRoute.withName('/'));
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
                Navigator.pushNamedAndRemoveUntil(
                    context, '/itilHome', ModalRoute.withName('/'));
              },
            )
          ],
        ),
      ),
    );
  }
}
