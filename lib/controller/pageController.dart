import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';

class PagesController extends GetxController {
  static PagesController get to => Get.find();
  RxInt pageIndex = 0.obs;
  // static 으로 클래스 귀속 시킴 이를 통해 컨트롤러 생성마다 달라지는게 아닌 어디에서 생성하더라도 같은 컨트롤러로 이용 가능
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  //글로벌키로 NavigationState 이용 현재 state 나 여러가지 읽어서 동작 가능
  void changePageIndex(int index) {
    pageIndex.value = index; // bottomNavigationBar 인덱스 변경
    log('pageIndex is $pageIndex');
  }




  // void onWillPop(){
  //   return navigatorKey.currentState!.pop();
  // } //취소키(back button) 방지 , 취소키 사용시 해당 동작을 하도록 설정 가능
  Future<bool> onWillPop() async {
    return !await navigatorKey.currentState!.maybePop();
  }
  void back(){
    onWillPop();
  }
}