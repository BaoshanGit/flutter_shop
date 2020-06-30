import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

Future getHomePageContent () async {
  try{
    Response response;
    Dio dio = new Dio();
    var format = {'lon':'115.02932','lat':'35.76189'};
    response = await dio.post(servicePath["HomePagePath"] , data: format);
    if(response.statusCode == 200){
      return response.data;
    }else{
      throw new Exception("数据请求异常，message==》"+response.statusMessage);
    }
  }catch(e){
    return print("数据请求异常，message==》${e}");
  }
}