import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tecnamex_features/constants.dart';
import 'package:tecnamex_features/drawer.dart';

class TabletBody extends StatefulWidget {
  const TabletBody({Key? key});

  @override
  State<TabletBody> createState() => _TabletBodyState();
}

class _TabletBodyState extends State<TabletBody> {
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
      drawer: MyDrawer(), // Change myDrawer() to MyDrawer()
      drawerScrimColor: Colors.transparent,
      body: Column(children: [
        //Var de saludo al usuario
        GreetingWidget,
      ]),
    );
  }
}
