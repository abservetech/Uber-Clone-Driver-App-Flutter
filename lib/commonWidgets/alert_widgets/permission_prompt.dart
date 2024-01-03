
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../../utils/utils.dart';
import '../common_widgets.dart';

// ignore: must_be_immutable
class PermissionPrompt extends StatelessWidget {
  PermissionPrompt({
    Key? key,
    required this.tapYes,
    required this.tapCancel,
  }) : super(key: key);

  VoidCallback tapYes;
  VoidCallback tapCancel;

  @override
  Widget build(BuildContext context) {
    return permissionSheet();
  }

  Widget permissionDialog(){
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: tapCancel,
            child: Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.topRight,
              child: const Icon(
                Icons.close,
                size: 20,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  alignment: Alignment.center,
                  child: Lottie.asset('assets/lottie_files/permission.json'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  Strings.permissionTitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Text(
                  Strings.permissionAlertContent,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.topRight,
            child: BottomButton(
                label: Strings.allowPermissions,
                borderRadius: 15,
                backgroundColor: AppColorData.appPrimaryColor,
                height: 35,
                labelColor: AppColorData.appSecondaryColor,
                onTap: tapYes),
          ),
        ],
      ),
    );
  }

  Widget permissionSheet(){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: AppColorData.appSecondaryColor
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Wrap(
          children: [
            Container(
              color: AppColorData.transparent,
              height: 5,),
            Center(
              child: Container(
                width: 100,
                color: AppColorData.appPrimaryColor.withOpacity(0.15),
                height: 3,),
            ),
            Container(
              color: AppColorData.transparent,
              height: 15,),
            Center(
              child: Container(
                  height: 180,width: 280,
                  color: AppColorData.transparent,
                  child: SvgPicture.asset(SVGAssets.locationPost,)),
            ),
            Container(
              color: Colors.transparent,
              height: 20,),
            Align(
              alignment: Alignment.center,
              child: Text(
                  Strings.permissionTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColorData.appPrimaryColor,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  )
              ),
            ),
            Container(
              color: Colors.transparent,
              height: 15,),
            Align(
              alignment: Alignment.center,
              child: Text(
                  Strings.permissionAlertContent,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.5,
                    color: AppColorData.grey03,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  )
              ),
            ),
            Container(
              color: Colors.transparent,
              height: 15,),

            CommonElevatedButton(
              height: 60,
              elevatedButtonNameColor: AppColorData.appPrimaryColor,
              elevatedButtonColor: AppColorData.appSecondaryColor,
              border: Border.all(color: AppColorData.appPrimaryColor),

              elevatedButtonName: Strings.allowPermissions,
              onTap: tapYes),
            Container(
              color: Colors.transparent,
              height: 15,),
          ],
        ),
      ),
    );
  }

}

