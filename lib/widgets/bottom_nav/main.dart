import 'package:flutter/material.dart';

class FancyBottomAppBar extends StatelessWidget {
  final Widget backButton;
  final List<Widget> menuItems;

  const FancyBottomAppBar({
    super.key,
    required this.backButton,
    required this.menuItems,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: BottomAppBar(
        elevation: 8,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Row(
            children: [
              const SizedBox(width: 16),
              backButton,
              const Spacer(),
              ...menuItems,
              const SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }
}
