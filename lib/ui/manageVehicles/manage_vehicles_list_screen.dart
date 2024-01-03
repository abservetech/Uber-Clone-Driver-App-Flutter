import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rebustar_driver/routes/router_pages.gr.dart';
import 'package:rebustar_driver/ui/manageVehicles/remove_vehicle_bottom_sheet.dart';

import '../../commonWidgets/common_widgets.dart';
import '../../utils/utils.dart';

@RoutePage()
class ManageVehiclesListPage extends StatefulWidget {
  const ManageVehiclesListPage({super.key});

  @override
  State<ManageVehiclesListPage> createState() => _ManageVehiclesListPageState();
}

class _ManageVehiclesListPageState extends State<ManageVehiclesListPage> {
  static int values = 5;
  List<bool> switchValues = List.generate(values, (index) => false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorData.appSecondaryColor,
      floatingActionButton: addButtonWidget(),
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          foregroundColor: AppColorData.appSecondaryColor,
          elevation: 0.9,
          pinned: true,
          floating: true,
          expandedHeight: 100,
          backgroundColor: AppColorData.appSecondaryColor,
          flexibleSpace: const CommonSliverAppBar(
            title: Strings.manageVehicleMenu,
          ),
          centerTitle: false,
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return vehicleCard(
              context: context,
              switchValue: switchValues[index],
              subTitle: "YAMAHA",
              title: "MT-15",
              image: SVGAssets.carSedan,
              deleteOnTap: (){
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  enableDrag: false,
                  isDismissible: false,
                  backgroundColor: AppColorData.appSecondaryColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  builder: (context) => RemoveVehicleBottomSheet(),
                );
              },
              editOnTap: (){
                context.router.push(AddNewVehiclesRoute(
                  color: "white",
                  dateYear: "22072001",
                  isEditPage: true,
                  licenceNo: "LICN2345434254",
                  model: "MT-15"
                ));
              },
              docOnTap: (){
                context.router.push(AddVehicleAndDriverDocumentsRoute());
              },
              onChanged: (value) {
                setState(() {
                  switchValues[index] = value;
                });
              });
        }, childCount: values))
      ]),
    );
  }

  Widget addButtonWidget() {
    return FloatingActionButton(
      onPressed: () {
        context.router.push(AddNewVehiclesRoute());
      },
      shape: const CircleBorder(),
      child: Icon(Icons.add, color: AppColorData.appSecondaryColor, size: 40),
    );
  }

  Widget vehicleCard(
      {String? title,
      String? subTitle,
      String? image,
        Function()? docOnTap,
        Function()? editOnTap,
        Function()? deleteOnTap,
      required bool switchValue,
      required void Function(bool)? onChanged,
      required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 5),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            side: BorderSide(color: AppColorData.dividerColor)),
        color: AppColorData.appSecondaryColor,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: [
              ListTile(
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
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(title ?? '',
                      style: TextStyle(
                          fontSize: 19,
                          color: AppColorData.appPrimaryColor,
                          fontWeight: FontWeight.w700)),
                ),
                subtitle: Text(
                  subTitle ?? '',
                ),
                trailing: Switch.adaptive(
                  trackOutlineWidth: const MaterialStatePropertyAll(1),
                  trackOutlineColor:
                      MaterialStatePropertyAll(AppColorData.appPrimaryColor),
                  activeColor: AppColorData.appPrimaryColor,
                  activeTrackColor: AppColorData.white02,
                  inactiveThumbColor: AppColorData.white02,
                  inactiveTrackColor: AppColorData.appSecondaryColor,
                  splashRadius: 20.0,
                  value: switchValue,
                  onChanged: onChanged,
                ),
              ),
              btnContainer(
                onTap: docOnTap,
                  context: context,
                  image: SVGAssets.doc_icon,
                  name: "Vehicle Document"),
              btnContainer(
                onTap: editOnTap,
                  context: context,
                  image: SVGAssets.edit_icon,
                  name: "Edit vehicle"),
              btnContainer(
                onTap: deleteOnTap,
                  context: context,
                  image: SVGAssets.delete_icon,
                  name: "Delete vehicle"),
            ],
          ),
        ),
      ),
    );
  }
}

Widget btnContainer(
    {required String image,
    required String name,
      Function()? onTap,
    required BuildContext context}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      color: AppColorData.transparent,
      width: MediaQuery.of(context).size.width * 0.26, //90,
      child: Column(
        children: [
          Container(
            height: 10,
            color: AppColorData.transparent,
          ),
          SvgPicture.asset(image),
          Container(
            height: 10,
            color: AppColorData.transparent,
          ),
          Text(name,
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 1,
                color: AppColorData.appPrimaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              )),
          Container(
            height: 10,
            color: AppColorData.transparent,
          ),
        ],
      ),
    ),
  );
}

