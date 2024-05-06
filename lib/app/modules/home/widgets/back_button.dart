import 'package:flutter/material.dart';

class BackButtonCustom extends StatelessWidget {
  const BackButtonCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.arrow_back_ios,
      color: Colors.black,
      size: 15,
    );
  }
}
