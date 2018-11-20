// My
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import '../../routes/AppNavigator.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffffffff), // 设置背景颜色
      child: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('点击跳转到cmdbHome'),
              onPressed: () {
                // navigator.navigateTo(context, '/cmdbHome');
                Navigator.pushNamedAndRemoveUntil(
                    context, '/cmdbHome', ModalRoute.withName('/'));
              },
            ),
            RaisedButton(
              child: Text('点击跳转到devOpsHome'),
              onPressed: () {
                // navigator.navigateTo(context, '/devOpsHome');
                Navigator.pushNamedAndRemoveUntil(
                    context, '/devOpsHome', ModalRoute.withName('/'));
              },
            ),
            RaisedButton(
              child: Text('点击跳转到itilHome'),
              onPressed: () {
                // navigator.navigateTo(context, '/itilHome');
                Navigator.pushNamedAndRemoveUntil(
                    context, '/itilHome', ModalRoute.withName('/'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
