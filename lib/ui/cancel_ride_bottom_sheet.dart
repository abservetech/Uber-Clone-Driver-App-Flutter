
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rebustar_driver/ui/home/home_screen.dart';
import '../../utils/utils.dart';
import '../commonWidgets/common_widgets.dart';

class CancelRideBottomSheet extends StatefulWidget {
  const CancelRideBottomSheet({super.key, this.isRideCanceledByDriver = true,});
  final bool? isRideCanceledByDriver;

  @override
  State<CancelRideBottomSheet> createState() => _CancelRideBottomSheetState();
}

class _CancelRideBottomSheetState extends State<CancelRideBottomSheet> {
  TextEditingController reasonInput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: AppColorData.appSecondaryColor
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: rideCanceledByDriverWidget("Waiting for Long time , Unable to contact driver")
      ),
    );
  }

  Widget rideCanceledByDriverWidget(String? reasonText){
    return Wrap(
      children: [
      Container(
      color: AppColorData.transparent,
      height: 5,),
    Center(
    child: Container(
    width: 100,
    color: AppColorData.appPrimaryColor.withOpacity(0.15),
    height: 3,),),
        Container(
          color: Colors.transparent,
          height: 20,),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
              Strings.requestRejectTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColorData.appPrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              )
          ),
        ),
        Container(
          color: Colors.transparent,
          height: 15,),
        Divider(
          color: AppColorData.white02,
          height: 1,
          thickness: 1,
        ),
        Container(
          color: Colors.transparent,
          height: 15,),
        SvgPicture.asset(SVGAssets.rideCanceledByDriverPost),
        Container(
          color: Colors.transparent,
          height: 15,),
        Align(
          alignment: Alignment.center,
          child: Text(
              "${Strings.rejectedReason} $reasonText",
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

        buttonsWidget()
      ],
    );
  }

  Widget buttonsWidget(){
    return CommonElevatedButton(
        height: 60,
        elevatedButtonName: Strings.goHomeBtnText,
        elevatedButtonColor: AppColorData.appSecondaryColor,
        elevatedButtonNameColor: AppColorData.appPrimaryColor,
        border: Border.all(color: AppColorData.appPrimaryColor),
        onTap: () async {
          FocusManager.instance.primaryFocus?.unfocus();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
          // context.router.pop();
        });
  }

}
