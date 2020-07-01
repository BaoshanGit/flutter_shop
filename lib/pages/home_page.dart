import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'widgets/swiper_widget.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("首页")),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context , val){
          if(val.hasData){
            var data = json.decode(val.data.toString());
            List<Map> swiperDataList = (data["data"]["slides"] as List).cast();
            return Column(
              children: <Widget>[
                SwiperDiy(swiperDataList: swiperDataList)
              ],
            );
          }else{
            return Center(
              child: Text("加载中...."),
            );
          }
        },
      ),
    );
  }
}
