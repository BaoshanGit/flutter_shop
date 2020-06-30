import 'package:flutter/material.dart';
import '../service/service_method.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String param;
  @override
  void initState() {
    getHomePageContent().then((val){
      setState(() {
        param = val;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
