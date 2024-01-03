import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rebustar_driver/ui/home/choose_vehical_bottom_sheet.dart';
import 'package:rebustar_driver/ui/home/trip_request_bottom_sheet.dart';

import '../../utils/utils.dart';

class OnlineOfflineBottomSheet extends StatefulWidget {
  const OnlineOfflineBottomSheet({super.key, this.isOnline});
  final bool? isOnline;

  @override
  State<OnlineOfflineBottomSheet> createState() => _OnlineOfflineBottomSheetState();
}

class _OnlineOfflineBottomSheetState extends State<OnlineOfflineBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: AppColorData.appSecondaryColor,
      ),
      child: (widget.isOnline == true) ? offlineSheet(): onlineSheet(),
    );
  }

 Widget onlineSheet() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Wrap(
        children: [
          Container(color: AppColorData.transparent,height: 4,),
          Center(
            child: Container(
              width: 100,
              color: AppColorData.appPrimaryColor.withOpacity(0.15),
              height: 3,),),
          Container(color: AppColorData.transparent,height: 10,),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                      Strings.backOnline,
                      style: TextStyle(
                        color: AppColorData.appPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      )
                  ),
                ),
                Container(color: AppColorData.transparent,width: 10,),
                Container(
                  width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: AppColorData.onlineColor,
                  borderRadius: BorderRadius.circular(100)
                )),
              ],
            ),
          ),
          Container(color: AppColorData.transparent,height: 10,),
          Divider(
            color: AppColorData.dividerColor,
            height: 1,
            thickness: 1,
            indent: 60,
            endIndent: 10,
          ),
          Container(color: AppColorData.transparent,height: 10,),
          driverCarCardWidget(
            onTap: (){
              showModalBottomSheet(
                  context: context,
                  enableDrag: false,
                  isDismissible: false,
                  backgroundColor: AppColorData.appSecondaryColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                  ),
                  builder:(context) => VehicleChooseBottomSheet(),);
            },
            context: context,
            image: SVGAssets.carSedan,
            title: "Ashwin Kumar",
            subTitle: "Toyata(Mini)",
            carNumber: "TN 56 BE 5678",),
          Container(color: AppColorData.transparent,height: 10,),
        ],
      ),
    );
 }
}

Widget offlineSheet() {
  return  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14.0),
    child: Wrap(
      children: [
        Container(color: AppColorData.transparent,height: 4,),
        Center(
          child: Container(
            width: 100,
            color: AppColorData.appPrimaryColor.withOpacity(0.15),
            height: 3,),),
        Container(color: AppColorData.transparent,height: 10,),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                    Strings.backOffline,
                    style: TextStyle(
                      color: AppColorData.appPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    )
                ),
              ),
              Container(color: AppColorData.transparent,width: 10,),
              Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      color: AppColorData.offlineColor,
                      borderRadius: BorderRadius.circular(100)
                  )),
            ],
          ),
        ),
        Container(color: AppColorData.transparent,height: 10,),
        Divider(
          color: AppColorData.dividerColor,
          height: 1,
          thickness: 1,

        ),
        Container(color: AppColorData.transparent,height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          driverRatingCardWidget(
            image: SVGAssets.acceptance_icon,
            percentage: "95.0%",
            type: "Acceptance"
          ),
          Container(color: AppColorData.dividerColor,height: 80,width: 1.5,),
          driverRatingCardWidget(
              image: SVGAssets.rating_icon,
              percentage: "4.75",
              type: "Rating"
          ),
          Container(color: AppColorData.dividerColor,height: 80,width: 1.5,),
          driverRatingCardWidget(
              image: SVGAssets.cancellation_icon,
              percentage: "2.0%",
              type: "Cancellation"
          ),
        ],),
        Container(color: AppColorData.transparent,height: 10,),
      ],
    ),
  );
}

Widget driverRatingCardWidget({required String image, required String percentage, required String type}){
  return Container(
    color: AppColorData.transparent,
    child: Column(
      children: [
        SvgPicture.asset(image),
        Container(height: 10,color: AppColorData.transparent,),
        Text(
            percentage,
            style: TextStyle(
              height: 1,
              color: AppColorData.appPrimaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            )
        ),
        Container(height: 10,color: AppColorData.transparent,),
        Text(
            type,
            style: TextStyle(
              height: 1,
              color: AppColorData.appPrimaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            )
        ),
        Container(height: 10,color: AppColorData.transparent,),
      ],
    ),
  );
}

Widget driverCarCardWidget(
    {Function()? onTap,
      String? title,
      String? subTitle,
      String? carNumber,
      String? image,
    required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Container(
      decoration: BoxDecoration(
        color: AppColorData.appSecondaryColor,
        borderRadius: BorderRadius.circular(10),
        //border: Border(left: BorderSide(color: AppColorData.appPrimaryColor))
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ListTile(
              onTap: onTap,
              contentPadding: const EdgeInsets.all(0),
              leading: Container(
                  color: AppColorData.transparent,
                  height: 70,
                  width: 70,
                  child: SvgPicture.asset(
                    image ?? '',
                  )),
              title: Container(
                color: AppColorData.transparent,
                width: MediaQuery.of(context).size.width *0.8,
                child: Text(title ?? '',
                    style: TextStyle(
                        fontSize: 19,
                        color: AppColorData.appPrimaryColor,
                        fontWeight: FontWeight.w700)),
              ),
              subtitle: Text(
                subTitle ?? '',
              ),
              trailing: Container(
                color: AppColorData.transparent,
                width: MediaQuery.of(context).size.width *0.25,
                child: Text(carNumber ?? "--",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColorData.appPrimaryColor
                )),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}