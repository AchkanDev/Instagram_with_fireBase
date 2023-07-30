import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/data/auth/repository/auth_repository.dart';
import 'package:instagram/responsive/bloc/responsive_layout_bloc.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({super.key, this.state, this.bloc});
  final ResponsiveLayoutState? state;
  final ResponsiveLayoutBloc? bloc;

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  ResponsiveLayoutBloc? bloc;

  void listnerDetails() {
    bloc?.add(ResponsiveLayoutStarted());
  }

  @override
  void initState() {
    AuthRepository.getDetailsValueNotifier.addListener(listnerDetails);
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
              ? Center(child: Text(state.userEntity.email))
              : const CircularProgressIndicator();
        },
      ),
    );
  }
}
