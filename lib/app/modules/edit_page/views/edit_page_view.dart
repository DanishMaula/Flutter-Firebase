import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_page_controller.dart';

class EditPageView extends GetView<EditPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
            future: controller.getData(Get.arguments),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var data = snapshot.data!.data() as Map<String, dynamic>;
                controller.nameC.text = data['name'];
                controller.priceC.text = data['price'];
                return Padding(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    children: [
                      TextField(
                        controller: controller.nameC,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Product Name',
                        ),
                      ),
                      TextField(
                        controller: controller.priceC,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText: 'Product Price',
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => controller.editProduct(
                            controller.nameC.text,
                            controller.priceC.text,
                            Get.arguments),
                          
                        child: Text('Edit Product'),
                      ),
                    ],
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}
