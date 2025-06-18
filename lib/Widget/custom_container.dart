import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget{
  final BorderRadius? radius;
  final double? height;
  final double? width;
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Decoration? decoration;

  CustomContainer({
    super.key,
    this.height,
    this.width,
    this.child,
    this.color,
    this.margin,
    this.radius,
    this.decoration
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: color,
      child: child,
      decoration:decoration,
    );
  }

}
