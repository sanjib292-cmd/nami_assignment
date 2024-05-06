import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nami_attendance/app/modules/home/views/home_view.dart';
import 'package:nami_attendance/app/modules/home/widgets/custom_appbar.dart';
import 'package:nami_attendance/app/modules/home/widgets/custom_button.dart';

class VerificationResult extends StatelessWidget {
  final Uint8List bytes;
  final CameraDescription? camera;
  const VerificationResult({required this.bytes, required this.camera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 360,
                  width: 290,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: MemoryImage(bytes), fit: BoxFit.cover)),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text('We couldnt recognize your face',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: .5),
                    )),
                const SizedBox(
                  height: 22,
                ),
                Container(
                  width: 290,
                  child: Text(
                      'Don’t Worry, your request for Attendance has been sent to the Head for approval!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            letterSpacing: .5),
                      )),
                ),
                const SizedBox(
                  height: 22,
                ),
                Container(
                  width: 290,
                  child: Text(
                      'Go to Dashboard and continue with your tasks for the day once your attendance is approved.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            letterSpacing: .5),
                      )),
                ),
              ],
            ),
            const Spacer(),
            const Divider(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
              child: CustomButton(
                  title: 'Go to Dashboard',
                  onPress: () {
                    Get.to(HomeView(
                      camera: camera,
                    ));
                  }),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
