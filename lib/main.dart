import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram/responsive/mobile_screen.dart';
import 'package:instagram/responsive/responsive_layout.dart';
import 'package:instagram/responsive/web_screen.dart';
import 'package:instagram/screen/root.dart';
import 'package:instagram/screen/auth/login/login_screen.dart';
import 'package:instagram/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

final ValueNotifier<ThemeMode> theme = ValueNotifier(ThemeMode.dark);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAFEsSX177xKECKeJNB41ofUqCvX_Xi78o",
          appId: "1:554740889018:web:26b1ce4d31d3b91f235983",
          messagingSenderId: "554740889018",
          projectId: "instagram-990ac",
          authDomain: "instagram-990ac.firebaseapp.com",
          storageBucket: "instagram-990ac.appspot.com",
          measurementId: "G-PW9EYYKGCK"),
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // void loadTheme() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     if (sharedPreferences.getString("theme") == "dark") {
  //       theme.value = ThemeMode.dark;
  //     } else {
  //       theme.value = ThemeMode.light;
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // loadTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nike Store',
        theme: theme.value == ThemeMode.dark
            ? MyAppThemeConfig.dark().getTheme()
            : MyAppThemeConfig.light().getTheme(),
        // home: Directionality(
        //     textDirection: TextDirection.rtl,
        //     child: RootScreen(
        //       onTap: methodSwitch,
        //     )
        //     ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                    mobileScreen: MobileScreen(), webScreen: WebScreen());
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return LoginScreen();
          },
        ));
  }

  void methodSwitch() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      if (theme.value == ThemeMode.dark) {
        sharedPreferences.setString("theme", "light");
        theme.value = ThemeMode.light;
      } else {
        sharedPreferences.setString("theme", "dark");
        theme.value = ThemeMode.dark;
      }
    });
  }
}
