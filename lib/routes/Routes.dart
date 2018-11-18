import 'package:fluro/fluro.dart';

// 引入handler
import './RoutesHandler.dart';

class Routes {
  // 以下是观察者模式的路由配置
  static void configureRoutes(Router router) {
    // 容错页面
    router.notFoundHandler = notFoundHandler;
    // 闪屏页
    router.define('/', handler: splashHandler);
    // CMDB首页
    router.define('/cmdbHome', handler: cmdbHomeHandler);
    // DevOps首页
    router.define("/devOpsHome", handler: devOpsHomeHandler);
    // ITIL首页
    router.define("/itilHome", handler: itilHomeHandler);
  }
}
