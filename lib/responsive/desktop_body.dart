import 'package:flutter/material.dart';
import 'package:tecnamex_features/constants.dart';
import 'package:tecnamex_features/drawer.dart';

class desktopBody extends StatefulWidget {
  const desktopBody({super.key});

  @override
  State<desktopBody> createState() => _desktopBodyState();
}

class _desktopBodyState extends State<desktopBody> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: myAppBar,
      backgroundColor: myBackground,
      body: Row(children: [
        //open drawer
        myDrawer(),

        //rest of the body
      ],),
    );
  }
}