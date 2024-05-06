import 'package:camera/camera.dart';
import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;
  static CameraCallback? cameraCallback;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(
        camera: cameraCallback != null ? cameraCallback!() : null,
      ),
      binding: HomeBinding(),
    ),
  ];
}

typedef CameraCallback = CameraDescription Function();
