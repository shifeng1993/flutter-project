import 'dart:core';
import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

abstract class TriangleDirection {
  // 左上
  static const String leftTop = 'leftTop';
  // 中上
  static const String centerTop = 'centerTop';
  // 右上
  static const String rightTop = 'rightTop';
  // 左中
  static const String leftMiddle = 'leftMiddle';
  // 右中
  static const String rightMiddle = 'rightMiddle';
  // 左下
  static const String leftBottom = 'leftBottom';
  // 中下
  static const String centerBottom = 'centerBottom';
  // 右下
  static const String rightBottom = 'rightBottom';
}

class Triangle extends StatefulWidget {
  Triangle(
      {Key key,
      this.direction,
      @required this.size,
      @required this.color,
      this.deg = 90,
      this.child})
      : super(key: key);

  final String direction;
  final Color color;
  final double size;
  final Widget child;
  final int deg;

  @override
  _TriangleState createState() => new _TriangleState();
}

class _TriangleState extends State<Triangle> {
  final double rightTopButtonSize = 40.0;
  Matrix4 actionsArrow = Matrix4.identity();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _TriangleCliper(
          radius: widget.size, direction: widget.direction, deg: widget.deg),
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Container(
          color: widget.color ?? widget.color,
          child: widget.child ?? widget.child,
        ),
      ),
    );
  }
}

class _TriangleCliper extends CustomClipper<Path> {
  final double radius;
  final String direction;
  final int deg;

  _TriangleCliper({this.radius, this.direction, this.deg});

  /// 角度转弧度公式
  double degree2Radian(int degree) {
    return (Math.pi * degree / 180) / 2; // 除以二是为了平分一个内角。
  }

  @override
  Path getClip(Size size) {
    double radius = this.radius;

    List<double> first;
    List<double> second;
    List<double> third;

    switch (this.direction) {
      case 'leftTop':
        first = [radius, 0.0];
        second = [0.0, radius];
        third = [0.0, 0.0];
        break;
      case 'rightTop':
        first = [0.0, 0.0];
        second = [radius, radius];
        third = [radius, 0.0];
        break;
      case 'leftBottom':
        first = [0.0, radius];
        second = [radius, radius];
        third = [0.0, 0.0];
        break;
      case 'rightBottom':
        first = [0.0, radius];
        second = [radius, 0.0];
        third = [radius, radius];
        break;
      case 'centerTop':
        first = [Math.sin(degree2Radian(deg)) * radius, 0.0];
        second = [
          2 * Math.sin(degree2Radian(deg)) * radius,
          Math.cos(degree2Radian(deg)) * radius
        ];
        third = [0.0, Math.cos(degree2Radian(deg)) * radius];
        break;
      case 'leftMiddle':
        first = [0.0, Math.sin(degree2Radian(deg)) * radius];
        second = [Math.cos(degree2Radian(deg)) * radius, 0.0];
        third = [
          Math.cos(degree2Radian(deg)) * radius,
          2 * Math.sin(degree2Radian(deg)) * radius
        ];
        break;
      case 'rightMiddle':
        first = [
          Math.cos(degree2Radian(deg)) * radius,
          Math.sin(degree2Radian(deg)) * radius
        ];
        second = [0.0, 0.0];
        third = [0.0, 2 * Math.sin(degree2Radian(deg)) * radius];
        break;
      case 'centerBottom':
        first = [
          Math.sin(degree2Radian(deg)) * radius,
          Math.cos(degree2Radian(deg)) * radius
        ];
        second = [2 * Math.sin(degree2Radian(deg)) * radius, 0.0];
        third = [0.0, 0.0];
        break;
      default:
    }
    Path path = new Path();
    path.moveTo(first[0], first[1]); // 此点为起点
    path.lineTo(second[0], second[1]);
    path.lineTo(third[0], third[1]);
    path.close(); // 闭合

    return path;
  }

  @override
  bool shouldReclip(_TriangleCliper oldClipper) {
    return this.radius != oldClipper.radius;
  }
}
