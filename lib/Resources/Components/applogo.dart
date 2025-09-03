import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final Size size;
  final String? type;
  const AppLogo({super.key, required this.size, this.type = 'black'});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: type == 'black'
            ? Image.asset("Assets/Images/Icons/logo-black.png")
            : Image.asset("Assets/Images/Icons/logo-white.png"),
      ),
    );
  }
}

class DisplayImage extends StatelessWidget {
  final Size size;
  final String imagePath;
  final double radius;
  const DisplayImage({
    super.key,
    required this.size,
    required this.imagePath,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.asset(imagePath),
      ),
    );
  }
}
