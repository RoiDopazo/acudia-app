import 'package:flutter/material.dart';

class BlinkingAnimation extends StatefulWidget {
  final Widget child;

  const BlinkingAnimation({Key key, this.child}) : super(key: key);

  @override
  _BlinkingAnimation createState() => _BlinkingAnimation(child);
}

class _BlinkingAnimation extends State<BlinkingAnimation> with SingleTickerProviderStateMixin {
  final Widget _child;

  AnimationController _animationController;

  _BlinkingAnimation(this._child);

  @override
  void initState() {
    _animationController = new AnimationController(vsync: this, lowerBound: 0.25, duration: Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _animationController, child: _child);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
