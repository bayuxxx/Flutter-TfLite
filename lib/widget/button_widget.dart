import 'package:flutter/material.dart';
import 'package:uas_ubay/color/colors.dart';

class ButtonClose extends StatelessWidget {
  const ButtonClose({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          color: Warna.cerah,
          borderRadius: BorderRadius.circular(45)),
      width: double.infinity,
      child: const Center(
        child: Text(
          'CLOSE CAMERA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
