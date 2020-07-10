/*
  轮播图组件
 */
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SwiperDiy extends StatelessWidget {
  //接收轮播图片地址
  final List swiperDataList;
  SwiperDiy({Key key , this.swiperDataList}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //设置轮播组件容器高度
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context , int index){
          return Image.network(swiperDataList[index]["image"],fit: BoxFit.fill);
        },
        itemCount: swiperDataList.length,
        autoplay: true,//是否自动播放
        pagination: new SwiperPagination(),//?
      ),
    );
  }
}

