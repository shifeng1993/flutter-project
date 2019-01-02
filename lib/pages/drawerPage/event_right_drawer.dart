// 资产选择的抽屉
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../common/baseStyle.dart';

class EventRightDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _drawer(context);
  }

  Widget _drawer(BuildContext context) {
    return Drawer(
      elevation: 0.0, // 去掉阴影
      semanticLabel: 'rightdrawer',
      child: Container(
        color: const Color(0xffffffff),
        child: Stack(
          children: <Widget>[
            SafeArea(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        left: 20, top: 10, right: 20, bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '选择资产类型',
                      style: TextStyle(
                        fontSize: BaseStyle.fontSize[1],
                        color: BaseStyle.textColor[2],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: BaseStyle.lineColor[0],
                          width: 1.0 / MediaQuery.of(context).devicePixelRatio,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
