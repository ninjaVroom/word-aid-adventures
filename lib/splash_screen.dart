import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:word_search_puzzle/widgets/screens/home/main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return FlutterSplashScreen.(
    //   gifPath: 'assets/images/splash.gif',
    //   gifWidth: 269,
    //   gifHeight: 474,
    //   backgroundColor: Colors.transparent,
    //   defaultNextScreen: const SafeArea(child: PuzzleHomePage()),
    //   duration: const Duration(milliseconds: 3515),
    //   onInit: () async {
    //     debugPrint("onInit 1");
    //     await Future.delayed(const Duration(milliseconds: 2000));
    //     debugPrint("onInit 2");
    //   },
    //   onEnd: () async {
    //     debugPrint("onEnd 1");
    //     debugPrint("onEnd 2");
    //   },
    // );
    return FlutterSplashScreen.fadeIn(
      backgroundColor: Colors.white,
      onInit: () {
        debugPrint("On Init");
      },
      onEnd: () {
        debugPrint("On End");
      },
      childWidget: SizedBox(
        height: 200,
        width: 200,
        child: Image.asset("assets/images/icon/logo.png"),
      ),
      onAnimationEnd: () => debugPrint("On Fade In End"),
      defaultNextScreen: const SafeArea(child: PuzzleHomePage()),
    );
  }
}
