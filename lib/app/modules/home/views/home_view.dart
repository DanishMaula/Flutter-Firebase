import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:get/get.dart';
import 'package:latihan_firebase1/app/routes/app_pages.dart';

import '../../../controllers/auth_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () => authC.logout(), icon: Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.streamData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var listAllDoc = snapshot.data!.docs;
            return ListView.builder(
                itemCount: listAllDoc.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () => Get.toNamed(Routes.EDIT_PAGE,
                   arguments: listAllDoc[index].id),

                  title: Text(
                    "${(listAllDoc[index].data() as Map<String, dynamic>)['name']}"
                  ),
                  subtitle: Text(
                    'Rp. ${(listAllDoc[index].data() as Map<String, dynamic>)['price']}'
                  ),
                  trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => 
                            controller.deleteProduct(listAllDoc[index].id),
                      ),
                      
                ),
                );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),


      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: Icon(Icons.add),
            onTap: () => Get.toNamed(Routes.ADD_PAGE),
            label :'Add item',
          ),
          SpeedDialChild(
            child: Icon(Icons.upload_file),
            onTap: () => controller.uploadFile(),
            label :'Upload a file',
          )
        ],
      ),
      );

  }
}


