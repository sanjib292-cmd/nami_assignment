import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nami_attendance/consts/consts.dart';

class DummyProgressBar extends StatefulWidget {
  const DummyProgressBar({super.key, required this.onPress});

  @override
  _DummyProgressBarState createState() => _DummyProgressBarState();
  final onPress;
}

class _DummyProgressBarState extends State<DummyProgressBar> {
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    startProgressAnimation();
  }

  void startProgressAnimation() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _progressValue += 0.01;
      });

      if (_progressValue >= 1.0) {
        timer.cancel();
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _progressValue = 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double percent = _progressValue * 100;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        child: percent.toStringAsFixed(0) == '100'
            ? Padding(
                padding: const EdgeInsets.only(bottom: 28.0),
                child: TextButton(
                  onPressed: widget.onPress,
                  child: Container(
                      // width: 150,
                      decoration: BoxDecoration(
                          color: AppResource.primaryClor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 17, vertical: 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/svg/retake.svg'),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('Re-Take',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.encodeSans(
                                      textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ))),
                            ),
                          ],
                        ),
                      )),
                ),
              )
            : Column(
                children: [
                  Text('${percent.toStringAsFixed(0)}% Scanning',
                      style: GoogleFonts.encodeSans(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: .5),
                      )),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: Get.width,
                    height: 8,
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(10),
                      backgroundColor: const Color(0xffFFECE2),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          AppResource.primaryClor),
                      value: _progressValue, // Set the progress value
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
