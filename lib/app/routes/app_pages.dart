import 'package:get/get.dart';

import 'package:latihan_firebase1/app/modules/add_page/bindings/add_page_binding.dart';
import 'package:latihan_firebase1/app/modules/add_page/views/add_page_view.dart';
import 'package:latihan_firebase1/app/modules/edit_page/bindings/edit_page_binding.dart';
import 'package:latihan_firebase1/app/modules/edit_page/views/edit_page_view.dart';
import 'package:latihan_firebase1/app/modules/home/bindings/home_binding.dart';
import 'package:latihan_firebase1/app/modules/home/views/home_view.dart';
import 'package:latihan_firebase1/app/modules/login/bindings/login_binding.dart';
import 'package:latihan_firebase1/app/modules/login/views/login_view.dart';
import 'package:latihan_firebase1/app/modules/reset_password/bindings/reset_password_binding.dart';
import 'package:latihan_firebase1/app/modules/reset_password/views/reset_password_view.dart';
import 'package:latihan_firebase1/app/modules/signup/bindings/signup_binding.dart';
import 'package:latihan_firebase1/app/modules/signup/views/signup_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PAGE,
      page: () => AddPageView(),
      binding: AddPageBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PAGE,
      page: () => EditPageView(),
      binding: EditPageBinding(),
    ),
  ];
}
