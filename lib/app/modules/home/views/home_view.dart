import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nami_attendance/app/modules/home/views/face_id_camera_view.dart';
import 'package:nami_attendance/app/modules/home/widgets/custom_appbar.dart';
import 'package:nami_attendance/app/modules/home/widgets/custom_button.dart';
import 'package:nami_attendance/consts/consts.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final CameraDescription? camera;
  const HomeView({required this.camera});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/png/face_id.png',
                height: 205,
                width: 205,
                // colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 45.0),
                child: Container(
                  width: 260,
                  child: Text(
                      'Initiate face verification for quick attendance Process.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.encodeSans(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: .5),
                      )),
                ),
              )
            ],
          ),
          Column(
            children: [
              Text('Privacy Notice',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    decoration: TextDecoration.underline,
                    textStyle: const TextStyle(
                        color: AppResource.primaryClor,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        letterSpacing: .5),
                  )),
              const Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                child: CustomButton(
                  title: 'Verify',
                  onPress: () {
                    Get.to(CameraScreen(camera: camera!));
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          )
        ],
      )),
    );
  }
}
