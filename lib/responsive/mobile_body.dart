import 'package:flutter/material.dart';
import 'package:tecnamex_features/constants.dart';
import 'package:tecnamex_features/drawer.dart';

class mobileBody extends StatefulWidget {
  const mobileBody({super.key});

  @override
  State<mobileBody> createState() => _mobileBodyState();
}

class _mobileBodyState extends State<mobileBody> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: myAppBar,
      backgroundColor: myBackground,
      drawer: myDrawer(),
      drawerScrimColor: Colors.transparent,
      body: Column(children: [

      ],),
    );
  } 
}