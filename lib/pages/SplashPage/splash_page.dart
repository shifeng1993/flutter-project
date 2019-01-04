// My
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../HomePage/CMDB_home_page.dart';
import '../HomePage/DevOps_home_page.dart';
import '../HomePage/ITIL_home_page.dart';

import '../../widgets/page_route_Builder/index.dart';

class SplashPage extends StatefulWidget {
  const SplashPage();

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  // 动画
  Animation animation;

  AnimationController controller;

  var animationStateListener;

  initState() {
    super.initState();
    //初始化动画管理器
    controller = new AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    //初始化动画
    animation = new Tween(begin: 1.0, end: 1.0).animate(controller);
    animationStateListener = (status) {
      if (status == AnimationStatus.completed) {
        // 这里可以跳转
        Navigator.pushReplacement(
          context,
          RouteBuilder.fadePage(CMDBHomePage()),
        );
      }
    };
    //注册动画观察者
    animation.addStatusListener((status) => animationStateListener(status));
    //启动动画
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new FadeTransition(
      opacity: animation,
      child: Container(
        width: 110.0,
        height: 110.0,
        color: const Color(0xffF0F2F5),
        child: Center(
          child: new Image.asset(
            "assets/images/launch_screen.gif",
            fit: BoxFit.cover,
            width: 110.0,
            height: 110.0,
          ),
        ),
      ),
    );
  }

  dispose() {
    controller.removeStatusListener(animationStateListener);
    controller.dispose();
    super.dispose();
  }
}
