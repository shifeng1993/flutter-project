import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluro/fluro.dart';

// 引入store
import './store/index.dart';
import './store/states/AppState.dart';

// 引入AppNavigator实体类
import './routes/AppNavigator.dart';

// 引入Routes配置
import './routes/Routes.dart';

// 根组件
class App extends StatelessWidget {
  final store = createStore();
  final color = const Color(0xffd33b32);  

  App() {
    final router = Router(); // 创建一个常量用来承载路由对象
    Routes.configureRoutes(router); // 使用配置来构造路由
    AppRouter.set(router); // 构造完成添加到实体类内
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: ThemeData(
          platform: TargetPlatform.iOS, // 使用ios的界面动画方式
          primaryColor: color, // 应用主要部分的背景颜色（工具栏，标签栏等）
          accentColor: Colors.white, // 前景色：旋钮，文本，过度滚动边缘效果等
        ),
        onGenerateRoute: AppRouter.get().generator, // 使用路由构建
      ),
    );
  }
}

// 输出渲染
void main() {
  runApp(App());
  if (Platform.isAndroid) {
    // 设置android状态栏为透明的沉浸。
    // 写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}
