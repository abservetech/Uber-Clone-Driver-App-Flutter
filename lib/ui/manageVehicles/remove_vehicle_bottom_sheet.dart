import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../commonWidgets/common_widgets.dart';
import '../../utils/utils.dart';

class RemoveVehicleBottomSheet extends StatefulWidget {
  const RemoveVehicleBottomSheet({super.key});

  @override
  State<RemoveVehicleBottomSheet> createState() => _RemoveVehicleBottomSheetState();
}

class _RemoveVehicleBottomSheetState extends State<RemoveVehicleBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            color: AppColorData.appSecondaryColor),
        child: Wrap(
          children: [
            Container(
              color: AppColorData.transparent,
              height: 5,
            ),
            Center(
              child: Container(
                width: 100,
                color: AppColorData.appPrimaryColor.withOpacity(0.15),
                height: 3,
              ),
            ),
            Container(
              color: Colors.transparent,
              height: 14,
            ),
            Center(
              child: Container(
                height: 100,
                width: 100,
                color: AppColorData.transparent,
                child: SvgPicture.asset(
                  SVGAssets.carSedan,
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              height: 14,
            ),
            Align(
              alignment: Alignment.center,
              child: Text("Remove Vehicle?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColorData.appPrimaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  )),
            ),

            Container(
              color: Colors.transparent,
              height: 14,
            ),
            Align(
              alignment: Alignment.center,
              child: Text("Are you sure want to remove this Vehicle ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.5,
                    color: AppColorData.grey05,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )),
            ),
            Container(
              color: Colors.transparent,
              height: 14,
            ),
            CommonElevatedButton(
              height: 60,
              elevatedButtonName: Strings.sure,
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                  Logger.appLogs("all items are validate");
                context.router.pop();
              },
            ),
            Container(
              color: Colors.transparent,
              height: 14,
            ),
            CommonElevatedButton(
              height: 60,
              elevatedButtonName: Strings.noThanksBtn,
              elevatedButtonColor: AppColorData.appSecondaryColor,
              elevatedButtonNameColor: AppColorData.appPrimaryColor,
              onTap: ()  {
                FocusManager.instance.primaryFocus?.unfocus();
                Logger.appLogs("all items are validate");
                context.router.pop();
              },
            ),
            Container(
              color: Colors.transparent,
              height: 14,
            ),
          ],
        ),
      ),
    );
  }
}

