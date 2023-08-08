import 'package:flutter/material.dart';
import 'package:total_x_work/screens/authchecker.dart';

class SplashsScreen extends StatefulWidget {
  const SplashsScreen({super.key});

  @override
  State<SplashsScreen> get createState => _SplashsScreenState();
}

class _SplashsScreenState extends State<SplashsScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController animationController2;
  late Animation<double> animation;
  late Animation<double> animation2;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
    animationController2 =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation2 = Tween<double>(begin: 0.4, end: 1).animate(animationController);

    animationController.forward();
    animationController2.forward();
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const AuthChecker(),
          ),
          (route) => false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Opacity(
              opacity: animation.value,
              child: AnimatedBuilder(
                  animation: animationController2,
                  builder: (context, chid) {
                    return Transform.scale(
                      scale: animation2.value,
                      child: const Center(
                        child: Text(
                          "Users",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }),
            );
          }),
    );
  }
}
