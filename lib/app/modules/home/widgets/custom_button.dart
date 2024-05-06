import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nami_attendance/consts/consts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.title, required this.onPress});
  final String title;

  final onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppResource.primaryClor),
      child: TextButton(
        onPressed: onPress,
        // () {
        //   Get.to(CameraScreen(camera: camera!));
        // },
        child: Text('$title',
            textAlign: TextAlign.center,
            style: GoogleFonts.encodeSans(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )),
      ),
    );
  }
}
