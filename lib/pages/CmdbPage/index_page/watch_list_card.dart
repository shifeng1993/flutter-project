// cmdb首页 关注的监控列表
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../common/baseStyle.dart';

import '../../../widgets/shadow_card/index.dart';

class WatchListCard extends StatefulWidget {
  WatchListCard({Key key, this.row}) : super(key: key);

  final Map row;

  @override
  _WatchListCardState createState() => new _WatchListCardState();
}

class _WatchListCardState extends State<WatchListCard> {
  List<Action> actions;

  @override
  void initState() {
    super.initState();
    actions = [
      Action('监控', ()  {
        print('监控');
        print(widget.row.toString());
      }),
      Action('取消', ()  {
        print('取消');
        print(widget.row.toString());
      })
    ];
  }

  @override
  Widget build(BuildContext context) {
    Widget statusImage;
    String statusText;
    switch (widget.row['status']) {
      case 0:
        statusImage = Container(
          margin: EdgeInsets.only(right: 5),
          child: Image.asset(
            'assets/icons/assets_status_error.png',
            width: 20,
            height: 20,
          ),
        );
        statusText = '宕机';
        break;
      case 1:
        statusImage = Container(
          margin: EdgeInsets.only(right: 5),
          child: Image.asset(
            'assets/icons/assets_status_normal.png',
            width: 20,
            height: 20,
          ),
        );
        statusText = '正常';
        break;
      case 2:
        statusImage = Container(
          margin: EdgeInsets.only(right: 5),
          child: Image.asset(
            'assets/icons/assets_status_warning.png',
            width: 20,
            height: 20,
          ),
        );
        statusText = '告警';
        break;
      default:
        statusImage = null;
        statusText = '未知';
        break;
    }

    List<int> flex = [8, 6, 7];

    TextStyle flexTextTitle = TextStyle(
        fontSize: BaseStyle.fontSize[1],
        color: BaseStyle.textColor[0],
        fontWeight: FontWeight.w500);

    TextStyle flexTextKey = TextStyle(
        fontSize: BaseStyle.fontSize[3],
        color: BaseStyle.textColor[2],
        fontWeight: FontWeight.w400);

    TextStyle flexTextVal = TextStyle(
        fontSize: BaseStyle.fontSize[3],
        color: BaseStyle.textColor[0],
        fontWeight: FontWeight.w500);

    return ShadowCard(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 15),
      onPressed: () {
        cardOnPress(widget.row);
      },
      actions: actions,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        statusImage,
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(right: 30.0),
                            child: Text(
                              widget.row['name'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: flexTextTitle,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: flex[0],
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('IP地址', style: flexTextKey),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.row['ip'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: flexTextVal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: flex[1],
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('资产类型', style: flexTextKey),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.row['type'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: flexTextVal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: flex[2],
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('PING检测状态', style: flexTextKey),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(statusText,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: flexTextVal),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void cardOnPress(row) {
    print(row.toString());
  }
}
