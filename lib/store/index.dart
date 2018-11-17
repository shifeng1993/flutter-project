import 'package:flutter/material.dart'; // 引入是为了获取ThemeData类
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_logging/redux_logging.dart';

import './reducers/index.dart';
import './states/AppState.dart';
import './middleware/index.dart';

// 创建Store对象
Store<AppState> createStore() {
  Store<AppState> store = new Store(
    appReducer,
    initialState: new AppState(new Map(), new List(), new ThemeData(),new Map()),
    middleware: [new LoggingMiddleware.printer(), thunkMiddleware],
  );
  return store;
}
