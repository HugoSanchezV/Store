import 'package:flutter/material.dart';

class ContainerIconButtonModel extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final Color? bgColor;
  final double? containerWidth;
  final VoidCallback? onTap;

  const ContainerIconButtonModel({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.iconSize,
    this.bgColor,
    this.containerWidth,
    this.onTap,
  }) : super(key: key);

  const ContainerIconButtonModel.withoutTap({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.iconSize,
    this.bgColor,
    this.containerWidth,
  }) : onTap = null, super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: containerWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: bgColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
          ],
        ),
      ),
    );
  }
}
