import 'package:flutter/material.dart';
import 'package:tecnamex_features/constants.dart';
import 'package:tecnamex_features/drawer.dart';

class tabletBody extends StatefulWidget {
  const tabletBody({super.key});

  @override
  State<tabletBody> createState() => _tabletBodyState();
}

class _tabletBodyState extends State<tabletBody> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: myAppBar,
      backgroundColor: myBackground,
      drawer: myDrawer(),
    );
  }
}