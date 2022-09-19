import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPageController extends GetxController {
   FirebaseFirestore firestore = FirebaseFirestore.instance;

  late TextEditingController nameC;
  late TextEditingController priceC;

  Future<DocumentSnapshot<Object?>> getData(String docId) async {
    DocumentReference docRef =
        firestore.collection('products').doc(docId);
    return await docRef.get();
  }

  void editProduct(String name, String price, String docId) async {
    DocumentReference docData = firestore.collection('products').doc(docId);

    try {
      await docData.update({
        'name': name,
        'price':price,
      });
      Get.defaultDialog(
          title: 'Sukses',
          middleText: 'Produk berhasil di update',
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
