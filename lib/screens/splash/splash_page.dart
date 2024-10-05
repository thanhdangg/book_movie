import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie/configs/app_color.dart';
import 'package:movie/configs/app_router.dart';
import 'package:movie/screens/home/home_page.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    // Simulate a delay for the API call
    await Future.delayed(const Duration(seconds: 3));
    // Navigate to HomePage
    context.router.replace(const HomeRoute());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColor.backgroundColor, // Set background color with 70% opacity
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background HomePage with blur effect
          // _buildBlurredBackground(),
          // Centered logo with fade-in animation
           Center(
              child: FadeTransition(
                opacity: _animation,
                child: Image.asset('assets/images/img_logo.png'),
              ),
            ),
        ],
      ),
    );
  }

  // Widget _buildBlurredBackground() {
  //   return FutureBuilder(
  //     future: _loadHomePage(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         return Stack(
  //           fit: StackFit.expand,
  //           children: [
  //             snapshot.data as Widget,
  //             BackdropFilter(
  //               filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
  //               child: Container(
  //                 color: Colors.black.withOpacity(0.5),
  //               ),
  //             ),
  //           ],
  //         );
  //       } else {
  //         return Container(color: Colors.white);
  //       }
  //     },
  //   );
  // }

  // Future<Widget> _loadHomePage() async {
  //   // Simulate loading HomePage
  //   await Future.delayed(const Duration(seconds: 3));
  //   return const HomePage(); // Replace with your HomePage widget
  // }
}