// cmdb资产/监控
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../common/baseStyle.dart';

import '../../../widgets/pull_list/index.dart';
import '../../../widgets/shadow_card/index.dart';

class CMDBAssetsPage extends StatefulWidget {
  CMDBAssetsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CMDBAssetsPageState createState() => new _CMDBAssetsPageState();
}

class _CMDBAssetsPageState extends State<CMDBAssetsPage> {
  List<Map<String, dynamic>> flexHeaderList;

  @override
  void initState() {
    super.initState();
    flexHeaderList = [
      {'flex': 1, 'imgPath': '', 'title': '', 'onPressed': () {}},
      {'flex': 1, 'imgPath': '', 'title': '', 'onPressed': () {}},
      {'flex': 1, 'imgPath': '', 'title': '', 'onPressed': () {}},
      {'flex': 1, 'imgPath': '', 'title': '', 'onPressed': () {}},
    ];
  }

  void _onRefresh(dynamic refreshController, bool up) {
    if (up)
      new Future.delayed(const Duration(milliseconds: 2009)).then((val) {
        setState(() {});
        refreshController.sendBack(true, RefreshStatus.completed);
      });
    else {
      new Future.delayed(const Duration(milliseconds: 2009)).then((val) {
        setState(() {});
        refreshController.sendBack(false, RefreshStatus.idle);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PullList(
        onRefresh: _onRefresh,
        child: new ListView(
          children: <Widget>[
            _headerCard(context),
          ],
        ),
      ),
    );
  }

  Widget _headerCard(BuildContext context) {
    List<Widget> children =
        (flexHeaderList == null || flexHeaderList.length == 0)
            ? <Widget>[]
            : flexHeaderList.take(4).map((item) {
                return _headerCardItem(item);
              }).toList(); // 列表
    return ShadowCard(
      margin: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
      padding: EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 15),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 15),
              child: Row(children: children),
            ),
          )
        ],
      ),
    );
  }

  Widget _headerCardItem(Map<String, dynamic> item) {
    return Expanded(
      flex: item['flex'],
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text('data'),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                item['title'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
