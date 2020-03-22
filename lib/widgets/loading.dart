import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

class LoadingWidget extends StatefulWidget {

  final Color backgroundColor;

  LoadingWidget({
    @required this.backgroundColor
  });

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation _borderWidthAnimation;


  @override
  void initState() {
    _controller = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this)
      ..repeat(reverse: true);

    _borderWidthAnimation = Tween<double>(begin: 15.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut
      )
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: widget.backgroundColor,
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Container(
                    width: constraints.maxWidth - (constraints.maxWidth / 5),
                    height: constraints.maxWidth - (constraints.maxWidth / 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: TinyColor(widget.backgroundColor).darken(10).color, width: _borderWidthAnimation.value),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: TinyColor(widget.backgroundColor).darken(80).color, blurRadius: 7.0, offset: const Offset(0.0, 0.0))
                        ]
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
