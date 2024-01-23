import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tecnamex_features/constants.dart';
import 'package:tecnamex_features/drawer.dart';

class mobileBody extends StatefulWidget {
  const mobileBody({super.key});

  @override
  State<mobileBody> createState() => _mobileBodyState();
}

class _mobileBodyState extends State<mobileBody> {
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
      //Utilizando var de constants
      appBar: myAppBar,
      backgroundColor: myBackground,
      drawer: myDrawer(),
      drawerScrimColor: Colors.transparent,
      body: Column(children: [
        //here we are calling the var GreetingWidget from constants.dart
        GreetingWidget,
      ]),
    );
  }
}
