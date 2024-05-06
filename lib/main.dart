import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  PermissionStatus cameraPermissionStatus = await Permission.camera.status;
  if (!cameraPermissionStatus.isGranted) {
    cameraPermissionStatus = await Permission.camera.request();
  }
  if (cameraPermissionStatus.isGranted) {
    final cameras = await availableCameras();
    final firstCamera = cameras.firstWhere(
        (element) => element.lensDirection == CameraLensDirection.front);
    AppPages.cameraCallback = () => firstCamera;

    runApp(
      GetMaterialApp(
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    );
  } else {
    print('Camera permission denied');
  }
}
