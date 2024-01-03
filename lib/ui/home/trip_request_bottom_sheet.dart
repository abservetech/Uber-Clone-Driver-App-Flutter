import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rebustar_driver/routes/router_pages.gr.dart';
import 'package:rebustar_driver/ui/call_screen.dart';
import 'package:rebustar_driver/ui/cancel_ride_bottom_sheet.dart';
import 'package:rebustar_driver/ui/home/home_screen.dart';
import 'package:rebustar_driver/ui/home/verify_trip_otp_bottom_sheet.dart';

import '../../commonWidgets/common_widgets.dart';
import '../../utils/utils.dart';

class TripAlertBottomSheet extends StatefulWidget {
  const TripAlertBottomSheet(
      {super.key, required this.cancelOnTap, required this.acceptOnTap, required this.context, this.isEndTripSheetShow = false});

  final Function() cancelOnTap;
  final Function() acceptOnTap;
  final BuildContext context;
  final bool? isEndTripSheetShow;

  @override
  State<TripAlertBottomSheet> createState() => _TripAlertBottomSheetState();
}

class _TripAlertBottomSheetState extends State<TripAlertBottomSheet> {
  bool isTripAccept = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: AppColorData.appSecondaryColor),
      child: ListView(
        shrinkWrap: true,
        children: [
          arrivalAndTripCompleteDriverInfoCardWidget(
              initialRating: 4.5, driverName: "Alena Carder"),
          (isTripAccept == true) ? driverInfoWidget() : SizedBox.shrink(),
          fromToAddressWidget(
              picUpDuration: "20 Min",
              distance: "1.5 Km",
              picUpAddress: "Simmakkal , Madurai",
              dropDuration: "40 mins",
              stopAddress: "54,Abservetech Private Limited",
              dropAddress: "Simmakkal"),
          buttonsWidget(context),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget arrivalAndTripCompleteDriverInfoCardWidget(
      {String? driverName, double? initialRating}) {
    return Card(
      elevation: 0,
      color: AppColorData.appSecondaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Wrap(
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
            Row(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  color: AppColorData.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: SvgPicture.asset(SVGAssets.emptyProfileImg),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  width: 15,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(driverName ?? '',
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          RatingBar.builder(
                            ignoreGestures: true,
                            initialRating: initialRating ?? 0.0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20,
                            unratedColor:
                                AppColorData.ratingColor.withOpacity(0.4),
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star_rate_rounded,
                              color: AppColorData.ratingColor,
                            ),
                            onRatingUpdate: (rating) {
                              Logger.appLogs(rating);
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("$initialRating",
                              style: TextStyle(
                                color: AppColorData.appPrimaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: Text("\$35.00",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      )),
                ),
              ],
            ),
            Container(
              height: 10,
            ),
            Divider(
              color: AppColorData.dividerColor,
              height: 1,
              thickness: 1,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget fromToAddressWidget(
      {String? picUpAddress,
      String? dropAddress,
      String? stopAddress,
      String? picUpDuration,
      String? dropDuration,
      String? distance}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: AppColorData.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: AppColorData.transparent,
                  height: (isTripAccept == true) ? 40 : 160,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(picUpDuration ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 17,
                                color: AppColorData.grey03,
                                fontWeight: FontWeight.w500)),
                      ),
                      (isTripAccept == true)
                          ? SizedBox.shrink()
                          : Text(dropDuration ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: AppColorData.grey03,
                                  fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
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
                    (isTripAccept == true || widget.isEndTripSheetShow == true)
                        ? SizedBox.shrink()
                        : textAndWidgets(
                            isPrefixWidget: true,
                            width: 20,
                            prefixWidget: Icon(
                              Icons.more_vert_rounded,
                              color: AppColorData.dotColor,
                            ),
                            suffixWidget: Center(
                              child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: CommonDashedLine(
                                      color: AppColorData.dotColor, height: 2)),
                            ),
                          ),
                    const SizedBox(
                      height: 6,
                    ),
                    (isTripAccept == true ||  widget.isEndTripSheetShow == true)
                        ? SizedBox.shrink()
                        : textAndWidgets(
                            isPrefixWidget: true,
                            width: 10,
                            prefixWidget: Icon(
                              Icons.my_location,
                              color: AppColorData.appPrimaryColor,
                              size: 24,
                            ),
                            //SvgPicture.asset(SVGAssets.location2),
                            suffixWidget: Container(
                              color: AppColorData.transparent,
                              width: MediaQuery.of(context).size.width * 0.65,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    stopAddress ?? '',
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

  Widget buttonsWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child:(widget.isEndTripSheetShow ==true)
          ? CommonElevatedButton(
        height: 60,
        elevatedButtonName: "Trip End",
        onTap: (){
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              enableDrag: false,
              isDismissible: false,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20))),
              backgroundColor: AppColorData.appSecondaryColor,
              builder: (context) => CancelRideBottomSheet(
                isRideCanceledByDriver: true,

              ));
         // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
        },
      )
      :Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: CommonElevatedButton(
                height: 60,
                border: Border.all(color: AppColorData.appPrimaryColor),
                elevatedButtonColor: AppColorData.appSecondaryColor,
                elevatedButtonNameColor: AppColorData.appPrimaryColor,
                elevatedButtonName:
                    (isTripAccept == true) ? Strings.cancel : Strings.decline,
                onTap: () {
                  widget.cancelOnTap();
                  context.router.pop();
                  setState(() {
                    isTripAccept = false;
                  });
                  PreferenceHelper.setBool(
                      PrefConstant.showOnlineButton, false);
                }),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 2,
            child: CommonElevatedButton(
                height: 60,
                elevatedButtonName:
                    (isTripAccept == true) ? Strings.arrived : Strings.accept,
                onTap: () {
                  widget.acceptOnTap();
                  setState(() {
                    isTripAccept = true;
                  });
                  if (isTripAccept == true) {
                    context.router.pop();
                    Future.delayed(Duration(milliseconds: 200), () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          enableDrag: false,
                          isDismissible: false,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
                          backgroundColor: AppColorData.appSecondaryColor,
                          builder: (context) => VerifyTripOtpBottomSheet(
                                cancelOnTap: () {
                      if (this.mounted) {
                        setState(() {
                          isTripAccept = false;
                        });
                      }
                                  widget.cancelOnTap();
                                },
                              ));
                    });
                  }
                }),
          )
        ],
      ),
    );
  }

  Widget arrivalIconsWithButtons(
      {required String icon, required String title, required int index}) {
    return GestureDetector(
      onTap: () {
        Logger.appLogs("index ::$index ::title ::$title");
        if (index == 1) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CallPage(),
          ));
        }
        else if(index == 2){
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

  Widget driverInfoWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              arrivalIconsWithButtons(
                  index: 1,
                  icon: SVGAssets.callIcon,
                  title: Strings.callBtnText),
              arrivalIconsWithButtons(
                  index: 2,
                  icon: SVGAssets.messageIcon,
                  title: Strings.messagesBtnText),
              arrivalIconsWithButtons(
                  index: 3,
                  icon: SVGAssets.direction_icon,
                  title: Strings.directionBtn),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Divider(
            color: AppColorData.dividerColor,
            height: 1,
            thickness: 1,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
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
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                )
            : Text(
                suffixText ?? '',
                style: TextStyle(
                    color: suffixTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              ),
      ],
    );
  }
}
