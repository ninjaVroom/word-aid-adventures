import 'package:flutter/material.dart';

class CongratulationsPopup extends StatefulWidget {
  final String userName;
  final VoidCallback onPlayAgain;

  const CongratulationsPopup({
    super.key,
    required this.userName,
    required this.onPlayAgain,
  });

  @override
  State<CongratulationsPopup> createState() => _CongratulationsPopupState();
}

class _CongratulationsPopupState extends State<CongratulationsPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<Color?> _blinkAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    _animationController.forward();

    _blinkAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.red,
    ).animate(_animationController);

    _startBlinkingAnimation();
  }

  void _startBlinkingAnimation() {
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      width: _animation.value * MediaQuery.of(context).size.width,
      height: _animation.value * MediaQuery.of(context).size.height,
      color: Colors.black54,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background design or animation
          // You can use blinking lights, fancy gaming animations, or any desired design here.

          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(
                  //   'Well Done, ${widget.userName}!'.toUpperCase(),
                  //   style: const TextStyle(
                  //     fontSize: 24,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  _buildWelldoneWidget(),
                  const SizedBox(height: 16),
                  Image.asset(
                    'assets/images/yay.gif', // Replace with your own image
                    height: 200,
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: const Text('Back'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: widget.onPlayAgain,
                            child: const Text('Next Game'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelldoneWidget() {
    return AnimatedBuilder(
      animation: _blinkAnimation,
      builder: (context, child) {
        return Text(
          'Well Done, ${widget.userName}!'.toUpperCase(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: _blinkAnimation.value,
          ),
        );
      },
    );
  }
}
