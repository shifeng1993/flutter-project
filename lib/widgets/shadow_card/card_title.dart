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
        onPressed != null
            ? Positioned(
                right: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(40 / 2)),
                  child: Material(
                    color: Color(0x00000000),
                    child: InkWell(
                      onTap: onPressed ?? () {},
                      highlightColor: Color.fromRGBO(0, 0, 0, 0.02),
                      splashColor: Color.fromRGBO(0, 0, 0, 0.04),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: Image.asset('assets/icons/next_b.png'),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
