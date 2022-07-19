import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeListViewController extends GetxController{
  var hasMore = false.obs;
  var isLoading = false.obs;
  var scrollCon = ScrollController().obs;
  var curIndex = 0.obs;
  var indexOffset = 30;
  var sData = <Map<String,dynamic>>[].obs;

  void indexChange(int i) => curIndex(i);
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void onInit() async{
    super.onInit();
    fetchData();
  }


  void onWillPop(){
    return navigatorKey.currentState!.pop();
  } //취소키(back button) 방지 , 취소키 사용시 해당 동작을 하도록 설정 가능

  void back() {
    onWillPop();
  }

  void fetchData() async{
    try{
      //var url ='3.37.87.99:3000/quotes';
      isLoading.value = true;
      http.Response response = await http.get(Uri.parse('http://3.35.218.81:8080/quotes'),);
      //var response = await http.get(Uri.http(url, '/'));

      if (response.statusCode == 200) {
        log(response.body);
        sData.value = json.decode(response.body).cast<Map<String,dynamic>>().toList();
        log('${sData.length}');

      }
      else{
        print('url failed');
      }
      isLoading.value = false;
    } catch(e){
      log(e.toString());
    }

  }

  void reload(){
    sData.clear();
    isLoading.value = false;
    hasMore.value = false;
    curIndex.value = 0;
    fetchData();
    log('Reloaded');
  }
}