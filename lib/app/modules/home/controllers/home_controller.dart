import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference products = firestore.collection('products');
    return products.snapshots();
  }

  void deleteProduct(String docId) async {
    DocumentReference docRef = firestore.collection('products').doc(docId);
    try {
      Get.defaultDialog(
          title: 'Konfirmasi',
          middleText: 'Apakah anda yakin ingin menghapus produk ini?',
          textConfirm: "Ya",
          confirmTextColor: Colors.white,
          textCancel: 'Tidak',
          onConfirm: () async {
            await docRef.delete();
            Get.back();
          });
    } catch (e) {
      print('Error : $e');
      Get.defaultDialog(
          title: 'Error',
          middleText: 'Gagal menghapus produk',
          textConfirm: "Ok");
    }
  }

  
}

