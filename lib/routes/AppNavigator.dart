import 'package:fluro/fluro.dart';

// 创建实体类
class AppRouter {
  static Router router;

  static Router get() {
    return router;
  }

  static void set(Router newRouter) {
    router = newRouter;
  }
}

var navigator = AppRouter.get();
