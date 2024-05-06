import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nami_attendance/app/modules/home/views/verification_result.dart';
import 'package:nami_attendance/app/modules/home/widgets/custom_appbar.dart';
import 'package:nami_attendance/app/modules/home/widgets/dummy_progress_bar.dart';
import 'package:nami_attendance/consts/consts.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({required this.camera});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  bool _isDetecting = false;
  late Interpreter _interpreter;
  late Uint8List _capturedImageBytes;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    _capturedImageBytes = Uint8List(0);
    loadModel();
  }

  void loadModel() async {
    try {
      final interpreterOptions = InterpreterOptions()..threads = 1;
      final interpreter = await Interpreter.fromAsset(
          'assets/png/facemodel.tflite',
          options: interpreterOptions);
      setState(() {
        _interpreter = interpreter;
      });
    } catch (e) {
      print('Failed to load model: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _interpreter.close();
    super.dispose();
  }

  void takePicture() async {
    if (!_controller.value.isInitialized) {
      return;
    }

    if (_isDetecting) {
      return;
    }

    try {
      _isDetecting = true;
      XFile file = await _controller.takePicture();
      var image = File(file.path);
      _capturedImageBytes = await image.readAsBytes();
      setState(() {});
    } catch (e) {
      print('Error taking picture: $e');
    } finally {
      _isDetecting = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Stack(
        children: [
          _capturedImageBytes != null && _capturedImageBytes!.isNotEmpty
              ? Container(
                  height: Get.height,
                  width: Get.width,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.memory(
                        fit: BoxFit.fill,
                        _capturedImageBytes!,
                      ),
                      Container(
                        color: Colors.black
                            .withOpacity(0.4), // Adjust opacity as needed
                      ),
                    ],
                  ),
                )
              : Container(
                  height: Get.height,
                  child: CameraPreview(_controller),
                ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text('Please look into the camera and hold still',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              letterSpacing: .5),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Center(
                      child: Image.asset(
                        'assets/png/rect.png',
                        height: 363,
                        width: 317,
                      ),
                    ),
                  ),
                ],
              ),
              _capturedImageBytes != null && _capturedImageBytes!.isNotEmpty
                  ? DummyProgressBar(
                      onPress: () {
                        setState(() {
                          _capturedImageBytes = Uint8List(0);
                          ;
                        });
                      },
                    )
                  : Container()
            ],
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        child: _capturedImageBytes != null && _capturedImageBytes!.isNotEmpty
            ? FloatingActionButton(
                backgroundColor: AppResource.primaryClor,
                onPressed: () {
                  Get.to(VerificationResult(
                    bytes: _capturedImageBytes,
                    camera: widget.camera,
                  ));
                },
                child: const Icon(
                  Icons.save,
                  color: Colors.white,
                ),
              )
            : FloatingActionButton(
                backgroundColor: AppResource.primaryClor,
                onPressed: takePicture,
                child: const Icon(Icons.camera, color: Colors.white),
              ),
      ),
    );
  }
}
