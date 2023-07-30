import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/data/auth/repository/auth_repository.dart';
import 'package:instagram/responsive/bloc/responsive_layout_bloc.dart';
import 'package:instagram/responsive/mobile_screen.dart';
import 'package:instagram/responsive/web_screen.dart';
import 'package:instagram/utils/constaint.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobileScreen;
  final Widget webScreen;

  const ResponsiveLayout(
      {super.key, required this.mobileScreen, required this.webScreen});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > maxWidth) {
          return widget.webScreen;
        } else {
          return widget.mobileScreen;
        }
      },
    );
  }
}
