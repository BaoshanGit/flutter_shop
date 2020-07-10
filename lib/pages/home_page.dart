import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'widgets/swiper_widget.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //初始化屏幕尺寸
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    return Scaffold(
      appBar: AppBar(title: Text("首页")),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context, val) {
          if (val.hasData) {
            var data = json.decode(val.data.toString());
            List<Map> swiperDataList = (data["data"]["slides"] as List).cast();
            List<Map> navigatorList = (data["data"]["category"] as List).cast();
            String bannerUrlStr = data["data"]["advertesPicture"]["PICTURE_ADDRESS"];
            String leaderTel =  data['data']['shopInfo']['leaderPhone']; //店长电话
            String  leaderImage= data['data']['shopInfo']['leaderImage'];  //店长图片
            return Column(
              children: <Widget>[
                SwiperDiy(swiperDataList: swiperDataList),
                TopNavigator(navigator:navigatorList),
                Banner(bannerUrl:bannerUrlStr),
                LeaderPhone(leaderTel:leaderTel, leaderPhoto:leaderImage),
              ],
            );
          } else {
            return Center(
              child: Text("加载中...."),
            );
          }
        },
      ),
    );
  }
}

//首页导航
class TopNavigator extends StatelessWidget {
  final List navigator;

  TopNavigator({Key key, this.navigator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.0),
      height: ScreenUtil().setHeight(320),
      child: GridView.count(
        crossAxisCount: 5, //设置每行个数
        padding: EdgeInsets.all(4.0),
        children: navigator.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }

  //设置每一个图片信息
  _gridViewItemUI(BuildContext context, items) {
    return InkWell(
      onTap: () {
        print(Text("点击了首页导航...."));
      },
      child: Column(
        children: <Widget>[
          Image.network(items["image"], width: ScreenUtil().setWidth(95)),
          Text(items["mallCategoryName"])
        ],
      ),
    );
  }
}

//广告图
class Banner extends StatelessWidget {
  final String bannerUrl ;
  Banner({Key key , this.bannerUrl}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(bannerUrl),
    );
  }
}

//拨打店长电话
class LeaderPhone extends StatelessWidget {
  final String leaderTel;
  final String leaderPhoto;
  LeaderPhone({Key key , this.leaderTel , this.leaderPhoto}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchUrl,
        child: Image.network(leaderPhoto),
      )
    );
  }

  //拨打电话
  void _launchUrl () async{
    String tel = "tel:"+leaderTel;
    if(await canLaunch(tel)){
      await launch(tel);
    }else{
      throw "can not launch ${tel}";
    }
  }
}


