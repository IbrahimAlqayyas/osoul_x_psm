import 'package:flutter/material.dart';

class VPadding extends StatelessWidget {
  const VPadding(this.height, {super.key});
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class HPadding extends StatelessWidget {
  const HPadding(this.width, {super.key});
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
