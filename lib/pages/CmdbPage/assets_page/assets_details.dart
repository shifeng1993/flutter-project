// cmdb资产 -> 资产管理
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../common/baseStyle.dart';
import '../../../utils/mock.dart';

import '../../../widgets/accordion/accordion_list.dart';
import '../../../widgets/accordion/accordion_list_item.dart';

class CMDBAssetsDetalisPage extends StatefulWidget {
  CMDBAssetsDetalisPage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _CMDBAssetsDetalisPageState createState() =>
      new _CMDBAssetsDetalisPageState();
}

class _CMDBAssetsDetalisPageState extends State<CMDBAssetsDetalisPage> {
  BuildContext context;
  Map<String, dynamic> assetsDetalisMap;
  List<String> assetsDetalisMapKeys;

  @override
  void initState() {
    super.initState();
    assetsDetalisMap = _getAssetsDetalisMap();
    assetsDetalisMapKeys = assetsDetalisMap.keys.toList();
  }

  List<Map<String, dynamic>> _getListRow() {
    int length = Random().nextInt(10);
    List<Map<String, dynamic>> list = List.generate(length, (i) {
      Map<String, dynamic> row = new Map();
      row['key'] = '属性${(i + 1).toString()}';
      row['val'] = 'dsaqfa';
      return row;
    });
    return list;
  }

  Map<String, dynamic> _getAssetsDetalisMap() {
    Map<String, dynamic> data = new Map();
    data['universalAttr'] = _getListRow();
    data['specialAttr'] = _getListRow();
    data['assetsAccount'] = _getListRow();
    data['protocolSet'] = _getListRow();
    data['docs'] = _getListRow();
    data['life'] = _getListRow();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return WillPopScope(
      child: Scaffold(
        appBar: _appbar(),
        body: _body(),
      ),
      onWillPop: _goback,
    );
  }

  Widget _appbar() {
    final iconSize = 22.0;
    return AppBar(
      title: Container(
        child: Center(
          child: Text(
            '资产详情',
            style: TextStyle(fontSize: BaseStyle.fontSize[0]),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
          icon: ImageIcon(
            AssetImage("assets/icons/back.png"),
            size: iconSize,
          ),
          onPressed: _goback,
        );
      }),
      actions: <Widget>[
        Container(
          width: iconSize + 26, // 加26是为了补齐偏差
          height: iconSize + 26, // 加26是为了补齐偏差
        ),
      ],
      centerTitle: false, // 消除 android 与 ios 页面title布局差异
      elevation: 0.0, // 去掉appbar下面的阴影
    );
  }

  Widget _body() {
    double itemHeight = 40.0;
    return AccordionList(
      listTitle: (BuildContext context, int index) {
        return Container(
          height: 50.0,
          color: Color(0x00000000), // 占满宽度
          alignment: Alignment.centerLeft,
          child: Text(
            assetsDetalisMapKeys[index],
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
      listMenu: (BuildContext context, int index) {
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: itemHeight,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      '12312321',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'fdsafdsafdsafddsafdsafdsakjfglhdsjkalhjkgldhsaklj',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: assetsDetalisMap[assetsDetalisMapKeys[index]].length ?? 0,
        );
      },
      itemHeight: (BuildContext context, int index) {
        int length = assetsDetalisMap[assetsDetalisMapKeys[index]].length;
        return length.toDouble() * itemHeight;
      },
      itemCount: assetsDetalisMapKeys.length ?? 0,
      // controller: new AnimationController(),
    );
  }

  void cardOnPress(row) {
    print(row.toString());
  }

  Future<bool> _goback() {
    print('_goback');
    Navigator.of(context).pop();
    return new Future.value(false);
  }
}
