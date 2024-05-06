import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nami_attendance/app/modules/home/widgets/back_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0, // Set title spacing to zero
      title: Padding(
        padding: const EdgeInsets.only(left: 8.0), // Adjust left padding
        child: Text(
          'Face Verification',
          style: GoogleFonts.encodeSans(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: .5,
            ),
          ),
        ),
      ),
      centerTitle: false,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 0),
        child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const BackButtonCustom()),
      ),
    );
  }
}
