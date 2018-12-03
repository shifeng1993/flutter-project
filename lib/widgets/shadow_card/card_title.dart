// cmdb首页图表
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../common/baseStyle.dart';

class ShadowCardTitle extends StatelessWidget {
  ShadowCardTitle({Key key, this.title, this.onPressed}) : super(key: key);

  final Function onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding:
              EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: BaseStyle.fontSize[1],
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: Material(
            child: InkWell(
              onTap: onPressed ?? () {},
              highlightColor: Color.fromRGBO(0, 0, 0, 0.02),
              splashColor: Color.fromRGBO(0, 0, 0, 0.04),
              child: Center(
                child: SizedBox.fromSize(
                  size: Size(50, 40),
                  child: Image.asset('assets/icons/next_b.png'),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
