import 'package:flutter/material.dart';
import 'package:instagram/responsive/mobile_screen.dart';
import 'package:instagram/responsive/responsive_layout.dart';
import 'package:instagram/responsive/web_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const ResponsiveLayout(
          mobileScreen: MobileScreen(), webScreen: WebScreen()),
    );
  }
}
