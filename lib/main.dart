import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tecnamex_features/responsive/desktop_body.dart';
import 'package:tecnamex_features/responsive/mobile_body.dart';
import 'package:tecnamex_features/responsive/responsive_layout.dart';
import 'package:tecnamex_features/responsive/tablet_body.dart';
import 'auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'theme/theme_provider.dart'; // Import your main app

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    // Provider for theme
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GetMaterialApp(
      title: 'Features',
      home: AuthChecker(),
      debugShowCheckedModeBanner: false,
      theme: themeProvider.themeData,
    );
  }
}

class AuthChecker extends StatelessWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If user is authenticated, show main app content
        if (snapshot.hasData) {
          return ResponsiveLayout(
  mobileBody: mobileBody(), // Replace with your mobile layout widget
  tabletBody: TabletBody(), // Replace with your tablet layout widget
  desktopBody: desktopBody(), // Replace with your desktop layout widget
);
        }
        // If user is not authenticated, show authentication page
        else {
          return AuthPage();
        }
      },
    );
  }
}
