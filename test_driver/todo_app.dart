// 集成测试 使用flutter drive --target test_driver/todo_app.dart 驱动

import 'package:flutter_driver/driver_extension.dart';
import '../lib/main.dart' as app;

void main() {
  enableFlutterDriverExtension();

  app.main();
}
