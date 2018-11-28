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
      padding: widget.padding == null ? EdgeInsets.all(10.0) : widget.padding,
      margin: widget.margin == null
          ? EdgeInsets.zero
          : widget.margin,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: widget.colors == null
              ? [Color(0xffffffff), Color(0xffffffff)]
              : widget.colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        image: widget.image,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: widget.color == null ? Color(0xffffffff) : widget.colors,
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
