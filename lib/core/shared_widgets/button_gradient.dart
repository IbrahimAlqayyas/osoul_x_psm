import 'package:flutter/material.dart';
import 'package:osoul_x_psm/core/theme/colors.dart';

class MyGradientButton extends StatefulWidget {
  final num height;
  final num width;
  final VoidCallback onPressed;
  final String label;
  final bool isSecondary;

  const MyGradientButton({
    super.key,
    this.height = 50,
    this.width = 164,
    required this.onPressed,
    required this.label,
    this.isSecondary = false,
  });

  @override
  MyGradientButtonState createState() => MyGradientButtonState();
}

class MyGradientButtonState extends State<MyGradientButton> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedContainer(
        height: _isPressed ? widget.height - 2 : widget.height.toDouble(),
        width: _isPressed ? widget.width - 2 : widget.width.toDouble(),
        duration: const Duration(milliseconds: 60),
        decoration: BoxDecoration(
          gradient: widget.isSecondary ? null : kMainGradient,
          color: widget.isSecondary ? kWhiteColor : null,
          border: widget.isSecondary ? Border.all(color: kPrimaryColor) : null,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: _isPressed
              ? []
              : [const BoxShadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 4.0)],
        ),
        child: Center(
          child: Text(
            widget.label,
            style: TextStyle(color: widget.isSecondary ? kPrimaryColor : kWhiteColor, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
