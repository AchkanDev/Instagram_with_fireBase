import 'package:flutter/material.dart';
import 'package:instagram/utils/constaint.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScreen;
  final Widget webScreen;

  const ResponsiveLayout(
      {super.key, required this.mobileScreen, required this.webScreen});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > maxWidth) {
          return webScreen;
        } else {
          return mobileScreen;
        }
      },
    );
  }
}
