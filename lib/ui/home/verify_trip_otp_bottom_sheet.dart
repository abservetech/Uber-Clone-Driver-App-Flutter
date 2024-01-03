import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:rebustar_driver/routes/router_pages.gr.dart';
import 'package:rebustar_driver/ui/call_screen.dart';
import 'package:rebustar_driver/ui/home/trip_request_bottom_sheet.dart';

import '../../commonWidgets/common_widgets.dart';
import '../../utils/utils.dart';

class VerifyTripOtpBottomSheet extends StatefulWidget {
  const VerifyTripOtpBottomSheet({super.key, required this.cancelOnTap});

  final Function() cancelOnTap;

  @override
  State<VerifyTripOtpBottomSheet> createState() =>
      _VerifyTripOtpBottomSheetState();
}

class _VerifyTripOtpBottomSheetState extends State<VerifyTripOtpBottomSheet> {
  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  int? otp;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.5,
        maxChildSize: 0.7,
        minChildSize: 0.5,
        expand: false,
        shouldCloseOnMinExtent: false,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: AppColorData.appSecondaryColor,
            ),
            child: ListView(
              shrinkWrap: true,
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              children: [
                otpWidget(),
                callChatBtnOption(),
                CommonElevatedButton(
                  height: 60,
                  elevatedButtonName: "Swipe to Start Ride  >>",
                  onHorizontalDragEnd: (details) {
                    if (details.primaryVelocity! < 0) {}
                    print("details :: ${details.velocity}");
                  },
                  onTap: () {
                    Future.delayed(Duration(microseconds: 2000), () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          enableDrag: false,
                          isDismissible: false,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
                          backgroundColor: AppColorData.appSecondaryColor,
                          builder: (context) => TripAlertBottomSheet(
                                isEndTripSheetShow: true,
                                cancelOnTap: () {
                                  widget.cancelOnTap();
                                },
                                acceptOnTap: () {},
                                context: context,
                              ));
                    });
                  },
                ),
                fromToAddressWidget(
                    distance: "1.5km",
                    dropAddress: "54,Abservetech Private Limited",
                    picUpAddress: "My Location",
                    tripDuration: "40 mins"),
                CommonElevatedButton(
                  height: 60,
                  elevatedButtonNameColor: AppColorData.appPrimaryColor,
                  elevatedButtonColor: AppColorData.appSecondaryColor,
                  border: Border.all(color: AppColorData.appPrimaryColor),
                  elevatedButtonName: Strings.cancel,
                  onTap: () {
                    context.router.pop();
                    PreferenceHelper.setBool(
                        PrefConstant.showOnlineButton, false);
                    widget.cancelOnTap();
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget otpWidget() {
    return Wrap(
      children: [
        Container(
          color: AppColorData.transparent,
          height: 4,
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
          height: 15,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text("Verify OTP",
              style: TextStyle(
                color: AppColorData.appPrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              )),
        ),
        Container(
          color: Colors.transparent,
          height: 15,
        ),
        Form(
          key: otpFormKey,
          child: OtpPinField(
              autoFocus: false,
              key: _otpPinFieldController,
              onSubmit: (text) {
                if (text == "4") {
                  Logger.appLogs('Entered pin is $text');

                  /// return the entered pin
                }
              },
              onChange: (text) {
                Logger.appLogs('Enter on change pin is $text');
                otp = int.tryParse(text);

                /// return the entered pin
              },
              cursorColor: AppColorData.appPrimaryColor,
              otpPinFieldStyle: OtpPinFieldStyle(
                  textStyle: TextStyle(
                      color: AppColorData.appPrimaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w700),
                  filledFieldBorderColor: AppColorData.appPrimaryColor,
                  defaultFieldBorderColor: AppColorData.defaultOtpBorderColor,
                  activeFieldBorderColor: AppColorData.appPrimaryColor),
              maxLength: 4,
              fieldHeight: MediaQuery.of(context).size.height * 0.09,
              fieldWidth: 70,
              otpPinFieldDecoration:
                  OtpPinFieldDecoration.defaultPinBoxDecoration),
        ),
        Container(
          color: Colors.transparent,
          height: 15,
        ),
        Divider(
          color: AppColorData.dividerColor,
          height: 1,
          thickness: 1,
        ),
        Container(
          color: Colors.transparent,
          height: 15,
        ),
      ],
    );
  }

  Widget callChatBtnOption() {
    return Wrap(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            callChatBtnWidget(
                index: 1, icon: SVGAssets.callIcon, title: Strings.callBtnText),
            callChatBtnWidget(
                index: 2,
                icon: SVGAssets.messageIcon,
                title: Strings.messagesBtnText),
            callChatBtnWidget(
                index: 3,
                icon: SVGAssets.direction_icon,
                title: Strings.directionBtn),
          ],
        ),
        Container(height: 10, color: AppColorData.transparent),
        Divider(
          color: AppColorData.dividerColor,
          height: 1,
          thickness: 1,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget fromToAddressWidget(
      {String? picUpAddress,
      String? dropAddress,
      String? tripDuration,
      String? distance}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10.0,
        ),
        Container(
          color: AppColorData.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: Text(tripDuration ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        color: AppColorData.grey03,
                        fontWeight: FontWeight.w500)),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                color: AppColorData.transparent,
                width: MediaQuery.of(context).size.width * 0.76,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textAndWidgets(
                        isPrefixWidget: true,
                        width: 10,
                        prefixWidget: SvgPicture.asset(SVGAssets.navigation),
                        suffixWidget: Container(
                          color: AppColorData.transparent,
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                picUpAddress ?? '',
                                maxLines: 1,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: AppColorData.appPrimaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                              Text(
                                distance ?? '',
                                maxLines: 1,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: AppColorData.grey03,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 6,
                    ),
                    textAndWidgets(
                      isPrefixWidget: true,
                      width: 20,
                      prefixWidget: Icon(
                        Icons.more_vert_rounded,
                        color: AppColorData.dotColor,
                      ),
                      suffixWidget: Center(
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: CommonDashedLine(
                                color: AppColorData.dotColor, height: 2)),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    textAndWidgets(
                        isPrefixWidget: true,
                        width: 10,
                        prefixWidget: SvgPicture.asset(SVGAssets.location2),
                        suffixText: dropAddress),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget callChatBtnWidget(
      {required String icon, required String title, required int index}) {
    return GestureDetector(
      onTap: () {
        Logger.appLogs("index ::$index ::title ::$title");
        if (index == 1) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CallPage(),
          ));
        } else if (index == 2) {
          context.router.push(ChatRoute());
        }
      },
      child: Container(
        color: AppColorData.transparent,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SvgPicture.asset(icon),
            const SizedBox(
              height: 10,
            ),
            Text(title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                )),
          ],
        ),
      ),
    );
  }

  Widget textAndWidgets(
      {String? prefixText,
      String? suffixText,
      bool? isPrefixWidget = false,
      Widget? prefixWidget,
      double? width,
      Widget? suffixWidget,
      Color? suffixTextColor,
      MainAxisAlignment? mainAxisAlignment}) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: [
        (isPrefixWidget == true)
            ? (prefixWidget ?? const SizedBox.shrink())
            : Text(
                prefixText ?? '',
                style: TextStyle(
                    color: AppColorData.appPrimaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              ),
        (isPrefixWidget == true)
            ? SizedBox(
                width: width,
              )
            : const SizedBox.shrink(),
        (isPrefixWidget == true)
            ? suffixWidget ??
                Container(
                  color: AppColorData.transparent,
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Text(
                    suffixText ?? '',
                    maxLines: 1,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: AppColorData.appPrimaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                )
            : Text(
                suffixText ?? '',
                style: TextStyle(
                    color: suffixTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 17),
              ),
      ],
    );
  }
}
