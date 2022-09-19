import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controller.emailC,
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
              ),
              TextField(
                controller: controller.passwordC,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.RESET_PASSWORD);
                    },
                    child: Text('Reset Password')),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () => authC.login(
                      controller.emailC.text, controller.passwordC.text),
                  child: Text('Login')),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Belum punya akun?'),
                  TextButton(
                      onPressed: () => Get.toNamed(Routes.SIGNUP),
                      child: Text('Daftar'))
                ],
              )
            ],
          ),
        ));
  }
}
