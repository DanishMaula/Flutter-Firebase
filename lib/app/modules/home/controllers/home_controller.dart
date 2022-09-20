import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //Firebase storage
  FirebaseStorage storage = FirebaseStorage.instance;

  void akses() async {
    var ref = storage.ref('Hello.txt');

    ref.putString('Hello world');
  }

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

  void uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      print(file);

      String fileName = result.files.first.name;
      String ext = result.files.first.extension!;

      try {
        await FirebaseStorage.instance.ref('${fileName}.${ext}').putFile(file);
        print('success upload file');
      } on FirebaseException catch (e) {
        print(e);
      }
      // User canceled the picker
      print('cancel file upload');
    }
  }

  
}
