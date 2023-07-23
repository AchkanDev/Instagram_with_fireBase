import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/screen/home/home_screen.dart';

const int homeIndex = 0;
const int cartIndex = 1;
const int profileIndex = 2;
const int themeindex = 3;

class RootScreen extends StatefulWidget {
  final GestureTapCallback onTap;
  const RootScreen({
    super.key,
    required this.onTap,
  });
  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedScreenIndex = homeIndex;
  final List<int> _history = [];

  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _cartKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    homeIndex: _homeKey,
    cartIndex: _cartKey,
    profileIndex: _profileKey,
  };

  Future<bool> _onWillPop() async {
    final NavigatorState currentSelectedTabNavigatorState =
        map[selectedScreenIndex]!.currentState!;
    if (currentSelectedTabNavigatorState.canPop()) {
      currentSelectedTabNavigatorState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = _history.last;
        _history.removeLast();
      });
      return false;
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: IndexedStack(index: selectedScreenIndex, children: [
            _navigator(_homeKey, homeIndex, const HomeScreen()),
          ]),
          bottomNavigationBar: Row(
            children: [
              Expanded(
                child: BottomNavigationBar(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  selectedItemColor: Theme.of(context).colorScheme.primary,
                  unselectedItemColor:
                      Theme.of(context).colorScheme.onBackground,
                  // fixedColor: Theme.of(context).colorScheme.onSecondary,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.home), label: 'خانه'),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.home), label: 'خانه'),
                  ],
                  currentIndex: selectedScreenIndex,
                  onTap: (selectedIndex) {
                    setState(() {
                      _history.remove(selectedScreenIndex);
                      _history.add(selectedScreenIndex);
                      selectedScreenIndex = selectedIndex;
                    });
                  },
                ),
              ),
              IconButton(
                onPressed: widget.onTap,
                icon: const Icon(CupertinoIcons.sun_max),
              )
            ],
          ),
        ));
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => Offstage(
                    offstage: selectedScreenIndex != index, child: child)));
  }
}
