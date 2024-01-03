import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/utils.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double? preferredHeight;
  final bool? automaticallyImplyLeading;
  final Color? backgroundColor;
  final double? elevation;
  final Widget? titleWidget;
  final Widget? leading;
  final List<Widget>? actions;
  final double? titleSpacing;
  final bool? centerTitle;
  final double? leadingWidth;
  final bool? isLeadingWidget;
  final bool? isTitleWidget;
  final bool? isMainPage;
  final String? titleText;
  final bool? forceMaterialTransparency;

  const CommonAppBar(
      {super.key,
        this.preferredHeight,
      this.automaticallyImplyLeading,
      this.backgroundColor,
      this.elevation,
      this.titleWidget,
      this.actions,
      this.leading,
      this.titleSpacing,
      this.centerTitle = false,
      this.leadingWidth,
      this.isLeadingWidget = false,
      this.isTitleWidget = false,
      this.titleText,
      this.isMainPage = false, this.forceMaterialTransparency= false});

  @override
  State<CommonAppBar> createState() => _CommonAppBarState();
  final double? preferredHeights = 65.0;

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(preferredHeights!);
}

class _CommonAppBarState extends State<CommonAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: widget.forceMaterialTransparency ?? false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColorData.appPrimaryColor
      ),
      automaticallyImplyLeading: widget.automaticallyImplyLeading ?? false,
      centerTitle: widget.centerTitle,
      backgroundColor: widget.backgroundColor ?? AppColorData.appPrimaryColor,
      elevation: widget.elevation,
      titleSpacing: widget.titleSpacing,
      title: (widget.isTitleWidget == false)
          ? Text(widget.titleText ?? '',
              style: TextStyle(
                  color: AppColorData.appPrimaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 20))
          : widget.titleWidget,
      actions: widget.actions,
      leading:
      (widget.isMainPage == true) ?
        const SizedBox.shrink()
       : (widget.isLeadingWidget == false)
          ? IconButton(
        icon: Icon(
            Platform.isIOS ?
            CupertinoIcons.back
                :Icons.arrow_back,
            color: AppColorData.appPrimaryColor,
            weight: 23),
        onPressed: () {
          Navigator.pop(context);
        },
      )
          : widget.leading,
      leadingWidth: widget.leadingWidth,
      shadowColor: Colors.transparent,
    );
  }
}
