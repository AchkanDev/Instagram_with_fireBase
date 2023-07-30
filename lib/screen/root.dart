import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/screen/addPost/add_post_screen.dart';
import 'package:instagram/screen/auth/login/login_screen.dart';
import 'package:instagram/screen/auth/signUp/signup_screen.dart';
import 'package:instagram/screen/home/home_screen.dart';

const int homeIndex = 0;
const int searchIndex = 1;
const int postIndex = 2;
const int favoriteIndex = 3;
const int profileIndex = 4;

class RootScreenMobile extends StatefulWidget {
  final GestureTapCallback onTap;
  const RootScreenMobile({
    super.key,
    required this.onTap,
  });
  @override
  State<RootScreenMobile> createState() => _RootScreenMobileState();
}

class _RootScreenMobileState extends State<RootScreenMobile> {
  int selectedScreenIndex = homeIndex;
  final List<int> _history = [];

  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _searchKey = GlobalKey();
  final GlobalKey<NavigatorState> _postKey = GlobalKey();
  final GlobalKey<NavigatorState> _favoriteKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    homeIndex: _homeKey,
    searchIndex: _searchKey,
    postIndex: _postKey,
    favoriteIndex: _favoriteKey,
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
            _navigator(_searchKey, searchIndex, SignUpScreen()),
            _navigator(_postKey, postIndex, AddPostScreen()),
            _navigator(_favoriteKey, favoriteIndex, SignUpScreen()),
            _navigator(_profileKey, profileIndex, SignUpScreen()),
          ]),
          bottomNavigationBar: Row(
            children: [
              Expanded(
                child: CupertinoTabBar(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  activeColor: Theme.of(context).colorScheme.onBackground,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.home), label: ""),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.search), label: ""),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.add_circled_solid),
                        label: ""),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.heart), label: ""),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.person), label: ""),
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
              // IconButton(
              //   onPressed: widget.onTap,
              //   icon: const Icon(CupertinoIcons.sun_max),
              // )
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
