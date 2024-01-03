import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rebustar_driver/routes/router_pages.gr.dart';
import '../../commonWidgets/common_widgets.dart';
import '../../utils/utils.dart';

class VehicleChooseBottomSheet extends StatefulWidget {
  const VehicleChooseBottomSheet({super.key});

  @override
  State<VehicleChooseBottomSheet> createState() => _VehicleChooseBottomSheetState();
}

class _VehicleChooseBottomSheetState extends State<VehicleChooseBottomSheet> {
  int? selectedRadio;
  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColorData.appSecondaryColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
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
            driverCarCardWidget(
              context: context,
              image: SVGAssets.carMini,
              title: "Honda",
              value: 1,
              subTitle: "Mini"
            ),
            Container(color: AppColorData.transparent,height: 10,),
            driverCarCardWidget(
                context: context,
                image: SVGAssets.carSedan,
                title: "Honda",
                value: 2,
                subTitle: "Sedan"
            ),
            Container(color: AppColorData.transparent,height: 10,),
            driverCarCardWidget(
                context: context,
                image: SVGAssets.carSuv,
                title: "Honda",
                value: 3,
                subTitle: "SUV"
            ),
            Container(color: AppColorData.transparent,height: 10,),
            buttonsWidget(context),
            Container(color: AppColorData.transparent,height: 10,),
          ],
        ),
      ),
    );
  }

  Widget buttonsWidget(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: CommonElevatedButton(
              height: 60,
              border: Border.all(color: AppColorData.appPrimaryColor),
              elevatedButtonColor: AppColorData.appSecondaryColor,
              elevatedButtonNameColor: AppColorData.appPrimaryColor,
              elevatedButtonName: Strings.manageVehiclesBtn,
              onTap: () {
                context.router.push(ManageVehiclesListRoute());
              }),
        ),
        const SizedBox(width: 10,),
        Expanded(
          flex: 2,
          child: CommonElevatedButton(
              height: 60,
              elevatedButtonName: Strings.addNewVehiclesBtn,
              onTap: () {
                context.router.push(AddNewVehiclesRoute());
              }),
        )
      ],
    );
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
    context.router.pop();
  }

  Widget driverCarCardWidget(
      {
        String? title,
        String? subTitle,
        required int value,
        String? image,
        required BuildContext context}) {
    return Card(
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(
          color: AppColorData.dividerColor
        )
      ),
      color: AppColorData.appSecondaryColor,
      elevation: 0,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ListTile(
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
              trailing: Radio(
                value: value,
                groupValue: selectedRadio,
                activeColor: AppColorData.appPrimaryColor,
                onChanged: (int? val) {
                  print("Radio $val");
                  setState(() {
                    setSelectedRadio(val ?? 0);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

}
