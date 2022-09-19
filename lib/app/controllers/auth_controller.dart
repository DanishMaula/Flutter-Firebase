import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_firebase1/app/routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  void signup(String email, String password) async {
    try {
      UserCredential myUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      //send verification email to exsisiting email
      await myUser.user!.sendEmailVerification();
      Get.defaultDialog(
        title: 'Verifikasi Email',
        middleText: 'Kami telah mengirimkan link verifikasi ke email ${email}',
        onConfirm: () {
          Get.back();
          Get.back();
        },
        textConfirm: 'OK',
        confirmTextColor: Colors.white,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Get.defaultDialog(
          title: 'Terjadi kesalahan',
          middleText: 'Password sangat lemah',
          onConfirm: () {
            Get.back();
            Get.back();
          },
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
        );
      } else if (e.code == 'email-already-in-use') {
        print('the account already exists for that email.');
        Get.defaultDialog(
          title: 'Terjadi Kesalahan',
          middleText: 'Email sudah terdaftar',
          onConfirm: () {
            Get.back();
            Get.back();
          },
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
        );
      }
    }
  }

  void login(String email, String password) async {
    try {
      UserCredential myUser = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (myUser.user!.emailVerified == true) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.defaultDialog(
          title: 'Email belum terverifikasi',
          middleText:
              'Anda memerlukan verifikasi email untuk masuk, apakah anda ingin mengirim ulang verifikasi email?',
          textConfirm: 'Kirim Ulang',
          confirmTextColor: Colors.white,
          onConfirm: () async {
            await myUser.user!.sendEmailVerification();
            Get.back();
          },
          textCancel: 'Batal',
          onCancel: () {
            Get.back();
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Get.defaultDialog(
          title: 'Terjadi Kesalahan',
          middleText: 'User tidak ditemukan',
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          },
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Get.defaultDialog(
          title: 'Terjadi kesalahan',
          middleText: 'Password salah',
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          },
        );
      }
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  void resetPassword(String email) async {
    if (email != "" && GetUtils.isEmail(email)) {
      try {
        auth.sendPasswordResetEmail(email: email);
        Get.defaultDialog(
          title: 'Success!',
          middleText: 'We have sent you a reset password to $email',
          onConfirm: () {
            Get.back(); // close dialog
            Get.back(); // go to login
          },
          textConfirm: "Ok",
        );
      } catch (e) {
        Get.defaultDialog(
          title: 'Error Occured',
          middleText: 'Cant reset password',
        );
      }
    } else {
      Get.defaultDialog(
        title: 'Error Occured',
        middleText: 'Please enter your email',
      );
    }
  }



}
