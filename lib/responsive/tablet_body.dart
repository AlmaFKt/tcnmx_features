import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tecnamex_features/constants.dart';
import 'package:tecnamex_features/drawer.dart';

class tabletBody extends StatefulWidget {
  const tabletBody({super.key});

  @override
  State<tabletBody> createState() => _tabletBodyState();
}

class _tabletBodyState extends State<tabletBody> {
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
      backgroundColor: myBackground,
      drawer: myDrawer(),
      drawerScrimColor: Colors.transparent,
      body: Column(children: [
        //Var de saludo al usuario
        GreetingWidget,
      ]),
    );
  }
}
