import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/data/auth/repository/auth_repository.dart';
import 'package:instagram/responsive/bloc/responsive_layout_bloc.dart';
import 'package:instagram/responsive/responsive_layout.dart';
import 'package:instagram/screen/root.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  ResponsiveLayoutBloc? bloc;

  void listnerDetails() {
    bloc?.add(ResponsiveLayoutStarted());
  }

  @override
  void initState() {
    // AuthRepository.getDetailsValueNotifier.addListener(listnerDetails);
    super.initState();
  }

  @override
  void dispose() {
    AuthRepository.getDetailsValueNotifier.removeListener(listnerDetails);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResponsiveLayoutBloc>(
      create: (context) {
        bloc = ResponsiveLayoutBloc(authRepository)
          ..add(ResponsiveLayoutStarted());
        return bloc!;
      },
      child: BlocBuilder<ResponsiveLayoutBloc, ResponsiveLayoutState>(
        builder: (context, state) {
          return state is ResponsiveLayoutSuccess
              ? RootScreenMobile(onTap: () {})
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
