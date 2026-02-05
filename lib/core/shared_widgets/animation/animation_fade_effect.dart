import 'package:flutter/material.dart';

class FadeEffect extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool loop; // Option to loop continuously

  const FadeEffect({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 1),
    this.loop = true, // Default set to true for continuous fade effect
  });

  @override
  FadeEffectState createState() => FadeEffectState();
}

class FadeEffectState extends State<FadeEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(vsync: this, duration: widget.duration);

    // Set up the animation to go between 0.0 (completely transparent) and 1.0 (completely opaque)
    _animation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Start the animation and set it to loop if required
    if (widget.loop) {
      _controller.repeat(reverse: true);
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(opacity: _animation.value, child: widget.child);
      },
    );
  }
}
