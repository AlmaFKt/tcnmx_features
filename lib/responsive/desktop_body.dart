import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tecnamex_features/theme/theme.dart';
import 'package:tecnamex_features/constants.dart';
import 'package:tecnamex_features/drawer.dart';

import '../components/body_content.dart';

class desktopBody extends StatefulWidget {
  const desktopBody({Key? key}) : super(key: key);

  @override
  State<desktopBody> createState() => _desktopBodyState();
}

class _desktopBodyState extends State<desktopBody> {
  late User? _user;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Row(
        children: [
          // Trayendo el Drawer dnetro del body
          Container(
            width: 200,
            child: MyDrawer(),
          ),

          // Body Content
          Expanded(
            child: Column(
              children: [
                // Widget var para saludar al usuario
                GreetingWidget,

                // Body Content
                Expanded(
                  child: BodyContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
