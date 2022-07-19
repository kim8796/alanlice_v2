import 'package:alanlice_v2/controller/HomeListViewController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class Home extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return const HomeListView();
  }
}


class HomeListView extends GetView<HomeListViewController>{
  const HomeListView({Key? key}) : super(key :key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.separated(
        controller: controller.scrollCon.value,
        padding: const EdgeInsets.all(8),
        itemBuilder: (_,index){
          if (controller.sData.length > index){
            var post = controller.sData[index]
                .map<String, String>((key, value) {
              return MapEntry(key.toString(), value.toString());
            });
            var uuidTest = post['uuidtest'] ?? '';
            var nm = post['name'] ?? '';
            return  GFListTile(
              title: Text(uuidTest),
              subTitle: Text(nm),
              avatar: GFAvatar(),
              icon: Icon(Icons.favorite),
            );
          }
          if (controller.hasMore.value ||
              controller.isLoading.value) {
            return Center(child: RefreshProgressIndicator());
          }
          return Container(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  children: [
                    Text('데이터의 마지막 입니다'),
                    IconButton(
                      onPressed: () {
                        controller.reload();
                      },
                      icon: Icon(Icons.refresh_outlined),
                    ),
                  ],
                ),
              ));
        },
        separatorBuilder: (BuildContext context, int index){
          return Divider();
        },
        itemCount: controller.sData.length+1)
    );
  }



}


