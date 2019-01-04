// devops -> 新建申请
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../common/baseStyle.dart';
import '../../../utils/mock.dart';

import '../../drawerPage/event_right_drawer.dart';
import '../../../widgets/list_item/list_item.dart';
import '../../../widgets/page_route_Builder/index.dart';
import '../../../widgets/triangle/index.dart';

class DevOpsNewApplicationPage extends StatefulWidget {
  DevOpsNewApplicationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DevOpsNewApplicationPageState createState() =>
      new _DevOpsNewApplicationPageState();
}

class _DevOpsNewApplicationPageState extends State<DevOpsNewApplicationPage> {
  BuildContext context;
  GlobalKey _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _goback() {
    print('_goback');
    Navigator.of(context).pop();
    return new Future.value(false);
  }

  List<Map<String, dynamic>> _getListRow(String typeStr) {
    int length = Random().nextInt(10);
    List<Map<String, dynamic>> list = List.generate(length, (i) {
      Map<String, dynamic> row = new Map();
      row['key'] = '${typeStr.toString()}${(i + 1).toString()}';
      row['val'] = '${typeStr.toString()}的值';
      return row;
    });
    return list;
  }

  Map<String, dynamic> _getformMap() {
    Map<String, dynamic> data = new Map();
    data['标题'] = _getListRow('通用属性');
    data['运维类型'] = _getListRow('特殊属性');
    data['开始时间'] = _getListRow('资产账户');
    data['结束时间'] = _getListRow('协议设置');
    data['文档'] = _getListRow('文档');
    data['生命周期'] = _getListRow('生命周期');
    return data;
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return WillPopScope(
      child: Scaffold(
        appBar: _appbar(),
        body: _body(),
        endDrawer: EventRightDrawer(),
      ),
      onWillPop: _goback,
    );
  }

  Widget _appbar() {
    final iconSize = 22.0;
    return AppBar(
      title: Container(
        margin:
            EdgeInsets.only(left: iconSize + 20), // 给marginleft补齐量，使title在屏幕中央
        child: Center(
          child: Text(
            '新建申请',
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
        IconButton(
          icon: ImageIcon(
            AssetImage("assets/icons/search_w.png"),
            size: iconSize,
          ),
          onPressed: () {
            print('搜索');
          },
        ),
        Builder(builder: (BuildContext context) {
          return IconButton(
            icon: ImageIcon(
              AssetImage("assets/icons/filter.png"),
              size: iconSize,
            ),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          );
        }),
      ],
      centerTitle: false, // 消除 android 与 ios 页面title布局差异
      elevation: 0.0, // 去掉appbar下面的阴影
    );
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: _form(),
            ),
          ),
          Container(
            height: 40.0,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      border: Border(
                        top: BorderSide(
                            width:
                                1.0 / MediaQuery.of(context).devicePixelRatio,
                            color: BaseStyle.lineColor[0]),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          '取消',
                          style: TextStyle(
                              fontSize: BaseStyle.fontSize[2],
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      border: Border(
                        top: BorderSide(
                            width:
                                1.0 / MediaQuery.of(context).devicePixelRatio,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          '提交',
                          style: TextStyle(
                              fontSize: BaseStyle.fontSize[2],
                              color: Color(0xffffffff)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _form() {
    double itemHeight = 50.0;
    BorderSide itemBorderWidth = BorderSide(
      color: BaseStyle.lineColor[0],
      width: 1.0 / MediaQuery.of(context).devicePixelRatio,
    );
    TextStyle keyStyle = TextStyle(
        fontSize: BaseStyle.fontSize[1], color: BaseStyle.textColor[0]);
    TextStyle valStyle = TextStyle(
        fontSize: BaseStyle.fontSize[2], color: BaseStyle.textColor[0]);
    TextStyle assetsNameStyle =
        TextStyle(fontSize: BaseStyle.fontSize[5], color: Color(0xffffffff));
    TextStyle assetsItemStyle = TextStyle(
        fontSize: BaseStyle.fontSize[5],
        color: Color.fromRGBO(255, 255, 255, 0.5));

    int assetsItemCount = 2;
    return Form(
      key: _formKey,
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          ListItem(
            listTitlePadding: EdgeInsets.only(left: 15, right: 15),
            listTitleDecoration: BoxDecoration(
              color: Color(0xffffffff),
              border: Border(
                top: itemBorderWidth,
              ),
            ),
            listTitle: (BuildContext context) {
              return Container(
                height: itemHeight,
                color: Color(0x00000000), // 占满宽度
                child: Row(
                  children: <Widget>[
                    Text('标题', style: keyStyle),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('SJ201806270001',
                            style: valStyle, overflow: TextOverflow.ellipsis),
                      ),
                    )
                  ],
                ),
              );
            },
            showRigtIcon: false,
          ),
          ListItem(
            listTitlePadding: EdgeInsets.only(left: 15, right: 10),
            listTitleDecoration: BoxDecoration(
              color: Color(0xffffffff),
              border: Border(
                top: itemBorderWidth,
              ),
            ),
            listTitle: (BuildContext context) {
              return Container(
                height: itemHeight,
                color: Color(0x00000000), // 占满宽度
                child: Row(
                  children: <Widget>[
                    Text('运维类型', style: keyStyle),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('日常维护',
                            style: valStyle, overflow: TextOverflow.ellipsis),
                      ),
                    )
                  ],
                ),
              );
            },
            showRigtIcon: true,
          ),
          ListItem(
            listTitlePadding: EdgeInsets.only(left: 15, right: 10),
            listTitleDecoration: BoxDecoration(
              color: Color(0xffffffff),
              border: Border(
                top: itemBorderWidth,
              ),
            ),
            listTitle: (BuildContext context) {
              return Container(
                height: itemHeight,
                color: Color(0x00000000), // 占满宽度
                child: Row(
                  children: <Widget>[
                    Text('开始时间', style: keyStyle),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('请选择',
                            style: valStyle, overflow: TextOverflow.ellipsis),
                      ),
                    )
                  ],
                ),
              );
            },
            showRigtIcon: true,
          ),
          ListItem(
            listTitlePadding: EdgeInsets.only(left: 15, right: 10),
            listTitleDecoration: BoxDecoration(
              color: Color(0xffffffff),
              border: Border(
                top: itemBorderWidth,
              ),
            ),
            listTitle: (BuildContext context) {
              return Container(
                height: itemHeight,
                color: Color(0x00000000), // 占满宽度
                child: Row(
                  children: <Widget>[
                    Text('结束时间', style: keyStyle),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('请选择',
                            style: valStyle, overflow: TextOverflow.ellipsis),
                      ),
                    )
                  ],
                ),
              );
            },
            showRigtIcon: true,
          ),
          ListItem(
            listTitlePadding: EdgeInsets.only(left: 15, right: 10),
            listTitleDecoration: BoxDecoration(
              color: Color(0xffffffff),
              border: Border(
                top: itemBorderWidth,
              ),
            ),
            listTitle: (BuildContext context) {
              return Container(
                height: itemHeight,
                color: Color(0x00000000), // 占满宽度
                child: Row(
                  children: <Widget>[
                    Text('申请理由', style: keyStyle),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    )
                  ],
                ),
              );
            },
            showRigtIcon: false,
          ),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
            color: Color(0xffffffff),
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '请输入你的故障现象或请求的详细描述',
                hintStyle: TextStyle(
                  fontSize: BaseStyle.fontSize[2],
                  color: BaseStyle.textColor[2],
                ),
              ),
              maxLines: null, // 最大行数设置为空则为多行输入
              maxLength: 100,
              enableInteractiveSelection: true,
              // onSaved: (val) {
              //   _name = val;
              // },
            ),
          ),
          ListItem(
            listTitlePadding: EdgeInsets.only(left: 15, right: 10),
            listTitleDecoration: BoxDecoration(
              color: Color(0xffffffff),
              border: Border(
                top: itemBorderWidth,
              ),
            ),
            listTitle: (BuildContext context) {
              return Container(
                height: itemHeight,
                color: Color(0x00000000), // 占满宽度
                child: Row(
                  children: <Widget>[
                    Text('选择资产', style: keyStyle),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    )
                  ],
                ),
              );
            },
            showRigtIcon: true,
            listMenuHeight: 92.0 * assetsItemCount.toDouble() + 10,
            listMenu: (BuildContext context) {
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 10),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int menuIndex) {
                  return _assetSelect(
                      assetsNameStyle: assetsNameStyle,
                      assetsItemStyle: assetsItemStyle);
                },
                itemCount: assetsItemCount,
              );
            },
          ),
          ListItem(
            listTitlePadding: EdgeInsets.only(left: 15, right: 10),
            listTitleDecoration: BoxDecoration(
              color: Color(0xffffffff),
              border: Border(
                top: itemBorderWidth,
              ),
            ),
            listTitle: (BuildContext context) {
              return Container(
                height: itemHeight,
                color: Color(0x00000000), // 占满宽度
                child: Row(
                  children: <Widget>[
                    Text('选择命令', style: keyStyle),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('请选择',
                            style: valStyle, overflow: TextOverflow.ellipsis),
                      ),
                    )
                  ],
                ),
              );
            },
            showRigtIcon: true,
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xffffffff),
              border: Border(
                top: itemBorderWidth,
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        height: MediaQuery.of(context).size.width / 4,
                        padding: EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          child: Container(
                            color: Color(0xffF5F7FA),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.add),
                                Text('上传照片',
                                    style: TextStyle(
                                        fontSize: BaseStyle.fontSize[4])),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _assetSelect({itemBorderWidth, assetsNameStyle, assetsItemStyle}) {
    return Container(
      color: Color(0xffF5F7FA),
      // height: 85.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Color(0x00000000),
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 15, right: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: Color(0x00000000),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xff74859D),
                                      Color(0xff4C5572)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('公共机器fdsasfs',
                                        style: assetsNameStyle,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                    Text('公共机器fdsafsad',
                                        style: assetsItemStyle,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                    Text('公共机器fsadfdas',
                                        style: assetsItemStyle,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                    Text('公共机器fsda',
                                        style: assetsItemStyle,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 10,
                    child: Triangle(
                      direction: TriangleDirection.leftTop,
                      size: 15,
                      color: Color(0xffF5F7FA),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: GestureDetector(
                      child: Image.asset('assets/icons/clean.png'),
                      onTap: () {
                        print('删除');
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Color(0x00000000),
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 5, top: 15, right: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: Color(0x00000000),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xff74859D),
                                      Color(0xff4C5572)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('公共机器fdsasfs',
                                        style: assetsNameStyle,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                    Text('公共机器fdsafsad',
                                        style: assetsItemStyle,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                    Text('公共机器fsadfdas',
                                        style: assetsItemStyle,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                    Text('公共机器fsda',
                                        style: assetsItemStyle,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 5,
                    child: Triangle(
                      direction: TriangleDirection.leftTop,
                      size: 15,
                      color: Color(0xffF5F7FA),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 10,
                    child: GestureDetector(
                      child: Image.asset('assets/icons/clean.png'),
                      onTap: () {
                        print('删除');
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
