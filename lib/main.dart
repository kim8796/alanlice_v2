import 'package:alanlice_v2/chatlist/chatlist.dart';
import 'package:alanlice_v2/controller/HomeListViewController.dart';
import 'package:alanlice_v2/controller/pageController.dart';
import 'package:alanlice_v2/home/home.dart';

import 'package:alanlice_v2/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
//import 'firebase_options.dart';

void main() async {
  //await initializeDefault();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


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
      home: const MainPage(title: 'Alanlice v0.2'),
    );
  }
}

class MainPage extends GetView<PagesController> {
  const MainPage({Key? key, required this.title}) : super(key: key);
  final String title;

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
          bottomNavigationBar: BtmNaviBar(),
        ));
  }
}

class BtmNaviBar extends StatelessWidget {
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
