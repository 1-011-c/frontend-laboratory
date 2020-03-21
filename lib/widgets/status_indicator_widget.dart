import 'package:flutter/material.dart';

class StatusIndicatorWidget extends StatefulWidget {

  IconData _icon;

  StatusIndicatorWidget.success() {
    _icon = Icons.check;
  }

  StatusIndicatorWidget.error() {
    _icon = Icons.error;
  }

  @override
  _StatusIndicatorWidgetState createState() => _StatusIndicatorWidgetState();
}

class _StatusIndicatorWidgetState extends State<StatusIndicatorWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _iconSizeAnimation;

  @override
  void initState() {
    _controller = AnimationController(duration: const Duration(milliseconds: 700), vsync: this)
      ..addListener(() {
        setState(() {

        });
      });

    _iconSizeAnimation = Tween<double>(begin: 0.0, end: 110.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Curves.bounceInOut
        )
    );

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth - (constraints.maxWidth / 5),
          height: constraints.maxWidth - (constraints.maxWidth / 5),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.grey, blurRadius: 7.0, offset: const Offset(0.0, 0.0))
              ]
          ),
          child: Center(
            child: Icon(widget._icon, size: _iconSizeAnimation.value, color: widget._icon == Icons.error ? Colors.red : Colors.blue),
          ),
        );
      },
    );
  }
}
