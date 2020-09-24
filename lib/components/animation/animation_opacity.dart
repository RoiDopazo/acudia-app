import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AcudiaAnimationOpacity extends StatelessWidget {
  final Widget child;
  final double opacity;

  const AcudiaAnimationOpacity({Key key, this.child, this.opacity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: this.opacity,
      duration: Duration(milliseconds: 500),
      child: this.child,
    );
  }
}
