import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPageController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late TextEditingController nameC;
  late TextEditingController priceC;

  void add(String name, String price) async {
    CollectionReference products = firestore.collection('products');

    try {
      await products.add({
        'name': name,
        'price':price,
      });
      Get.defaultDialog(
          title: 'Sukses',
          middleText: 'Produk berhasil ditambahkan',
          onConfirm: () {
            nameC.clear();
            priceC.clear();
            Get.back();
            Get.back();
          },
          textConfirm: "Ok",
          confirmTextColor: Colors.white);
    } catch (e) {
      print('Error : $e');
      Get.defaultDialog(
          title: 'Error',
          middleText: 'Terjadi kesalahan',
          textConfirm: "Ok");
    }
  }

  @override
  void onInit() {
    nameC = TextEditingController();
    priceC = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    nameC.dispose();
    priceC.dispose();
    super.dispose();
  }

  
}
