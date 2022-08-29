import 'dart:async';
import 'dart:developer';

import 'package:alanlice_v2/chatlist/chatlist.dart';
import 'package:alanlice_v2/controller/HomeListViewController.dart';
import 'package:alanlice_v2/controller/pageController.dart';
import 'package:alanlice_v2/home/home.dart';

import 'package:alanlice_v2/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'firebase_options.dart';

void main() async {
  //await initializeDefault();
  WidgetsFlutterBinding.ensureInitialized();
  log(DefaultFirebaseOptions.currentPlatform.appId);
  log(DefaultFirebaseOptions.currentPlatform.projectId);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform, name: 'Alanlice');

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

   static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
   static FirebaseAnalyticsObserver observer =
   FirebaseAnalyticsObserver(analytics: analytics);


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Alanlice v0.2',
      initialBinding: BindingsBuilder(() {
        Get.put(PagesController());
        Get.put(HomeListViewController());
      }),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      home: MainPage(title: 'Alanlice v0.2', analytics: analytics, observer: observer,),
      //home: MainPage(title: 'Alanlicev0.2',),
    );
  }
}

class MainPage extends GetView<PagesController> {
  const MainPage({Key? key, required this.title, required this.analytics, required this.observer}) : super(key: key);

  //const MainPage({Key? key , required this.title}) : super(key:key);
  final String title;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;




  Future<void> testEvents() async{
    // await analytics.logAppOpen();
    // await analytics.logAddPaymentInfo();
    // await analytics.logEarnVirtualCurrency(
    //   virtualCurrencyName: 'bitcoin',
    //   value: 345.66,
    // );
    // await analytics.logGenerateLead(
    //   currency: 'USD',
    //   value: 123.45,
    // );
    await analytics.logBeginCheckout(
        value: 10.0,
        currency: 'USD',
        items: [
          AnalyticsEventItem(
              itemName: 'Socks',
              itemId: 'xjw73ndnw',
              price: 10.0
          ),
        ],
        coupon: '10PERCENTOFF'
    );
    log("analytics log test");
  }
  testEvent() {
    // TODO: implement testEvent
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: [Home(), Chatlist(), Setting()],
          ),
          bottomNavigationBar: BtmNaviBar(
          ),
        ));
  }
}

class BtmNaviBar extends StatelessWidget {

 // BtmNaviBar({Key? key, required this.analytics, required this.observer}) : super(key:key);


  var controller = Get.find<PagesController>();


  BtmNaviBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BottomNavigationBar(
        currentIndex: controller.pageIndex.value,
        onTap: controller.changePageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people, color: Colors.grey),
            label: 'home',
            activeIcon: Icon(Icons.people, color: Colors.blue),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline, color: Colors.grey),
            label: 'chat',
            activeIcon: Icon(Icons.chat_bubble_outline, color: Colors.blue),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.grey),
            label: 'settings',
            activeIcon: Icon(Icons.settings, color: Colors.blue),
          ),
        ]);
    //throw UnimplementedError();
  }
}
