import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 import 'package:tecnamex_features/responsive/desktop_body.dart';
import 'package:tecnamex_features/responsive/mobile_body.dart';
import 'package:tecnamex_features/responsive/responsive_layout.dart';
import 'package:tecnamex_features/responsive/tablet_body.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}): super (key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Features',
      home: ResponsiveLayout(
        mobileBody:const mobileBody(),
        tabletBody: const tabletBody(),
        desktopBody: const desktopBody(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}