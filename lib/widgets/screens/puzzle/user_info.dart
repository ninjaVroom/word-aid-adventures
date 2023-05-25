import 'package:flutter/material.dart';

class ArcadeWidget extends StatefulWidget {
  final String name;
  final String level;

  const ArcadeWidget({super.key, required this.name, required this.level});

  @override
  State<ArcadeWidget> createState() => _ArcadeWidgetState();
}

class _ArcadeWidgetState extends State<ArcadeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _blinkAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _blinkAnimation = ColorTween(
      begin: Colors.transparent,
      end: Colors.red,
    ).animate(_animationController);

    _startBlinkingAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startBlinkingAnimation() {
    _animationController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildNameWidget(),
          const Spacer(),
          _buildLevelWidget(),
        ],
      ),
    );
  }

  Widget _buildNameWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "USER",
          style: TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.displayLarge!.color,
          ),
        ),
        Text(
          widget.name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.displayLarge!.color,
          ),
        )
      ],
    );
  }

  Widget _buildLevelWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "LEVEL",
          style: TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.displayLarge!.color,
          ),
        ),
        AnimatedBuilder(
          animation: _blinkAnimation,
          builder: (context, child) {
            return Text(
              widget.level,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _blinkAnimation.value,
              ),
            );
          },
        ),
      ],
    );
  }
}
