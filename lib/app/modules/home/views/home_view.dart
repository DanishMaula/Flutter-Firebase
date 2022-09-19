import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
                  title: Text(
                    "${(listAllDoc[index].data() as Map<String, dynamic>)['name']}'"
                  ),
                  subtitle: Text(
                    'Rp. ${(listAllDoc[index].data() as Map<String, dynamic>)['price']}'
                  ),
                ),
                );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),

      
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Get.toNamed(Routes.ADD_PAGE),
      ),
    );
  }
}


