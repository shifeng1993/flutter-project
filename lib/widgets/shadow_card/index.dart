// cmdb首页图表
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ShadowCard extends StatefulWidget {
  ShadowCard(
      {Key key,
      this.child,
      this.margin,
      this.padding,
      this.colors,
      this.color,
      this.image})
      : super(key: key);

  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final List<Color> colors;
  final DecorationImage image;
  final Color color;

  @override
  _ShadowCardState createState() => new _ShadowCardState();
}

class _ShadowCardState extends State<ShadowCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? EdgeInsets.all(10.0),
      margin: widget.margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: widget.colors ?? [Color(0xffffffff), Color(0xffffffff)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        image: widget.image,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: widget.color ?? Color(0xffffffff),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.04),
            offset: new Offset(0.0, 0.0),
            blurRadius: 3.0,
          ),
        ],
      ),
      child: widget.child,
    );
  }
}
