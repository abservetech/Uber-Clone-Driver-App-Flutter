import 'package:flutter/material.dart';

import '../../utils/utils.dart';


class CommonElevatedButton extends StatefulWidget {
  final String elevatedButtonName;
  final Color? elevatedButtonColor;
  final Color? elevatedButtonNameColor;
  final Function()? onTap;
  final GestureDragEndCallback? onHorizontalDragEnd;
  final double? height;
  final double? width;
  final Widget? icon;
  final BoxBorder? border;

  const CommonElevatedButton(
      {super.key,
        required this.elevatedButtonName,
        this.onTap,
        this.height,
        this.width,
        this.icon,
        this.elevatedButtonColor,
        this.elevatedButtonNameColor,
        this.border,
        this.onHorizontalDragEnd});

  @override
  State<CommonElevatedButton> createState() => _CommonElevatedButtonState();
}

class _CommonElevatedButtonState extends State<CommonElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: widget.onTap,
      onHorizontalDragEnd: widget.onHorizontalDragEnd,
      child: Container(height: widget.height ?? 60,
        // 70,// MediaQuery.of(context).size.height *0.08,//
        width: widget.width,
        //378,// MediaQuery.of(context).size.width *0.98,//
        decoration: BoxDecoration(
            color: widget.elevatedButtonColor ?? AppColorData.appPrimaryColor,
            borderRadius: BorderRadius.circular(10),
            border: widget.border),
        child: Center(child: (widget.icon != null) ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (widget.icon != null) ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: widget.icon ?? const SizedBox.shrink(),) : const SizedBox
                .shrink(),
            Text(widget.elevatedButtonName, maxLines: 2,
              style: TextStyle(fontWeight: FontWeight.w700,
                  fontSize: 20,
                  overflow: TextOverflow.ellipsis,
                  color: widget.elevatedButtonNameColor ??
                      AppColorData.appSecondaryColor),),
          ],) : Text(widget.elevatedButtonName, maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w700,
              fontSize: 20,
              overflow: TextOverflow.ellipsis,
              color: widget.elevatedButtonNameColor ??
                  AppColorData.appSecondaryColor),),),),);
  }
}
