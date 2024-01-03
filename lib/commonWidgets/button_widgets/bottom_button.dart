import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    Key? key,
    this.onTap,
    this.height = 50.0,
    required this.label,
    this.borderRadius = 25.0,
    this.labelColor = ThemeColor.Black,
    this.backgroundColor = ThemeColor.Green3,
  }) : super(key: key);

  final VoidCallback? onTap;
  final String label;
  final Color? backgroundColor;
  final double? borderRadius;
  final Color? labelColor;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0),
          backgroundColor: onTap != null
              ? MaterialStateProperty.all<Color>(backgroundColor!)
              : MaterialStateProperty.all<Color>(ThemeColor.Grey2),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
            ),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: AppColorData.appSecondaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
          ),
        ),
      ),
    );
  }
}
