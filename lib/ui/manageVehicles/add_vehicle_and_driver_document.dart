import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rebustar_driver/routes/router_pages.gr.dart';

import '../../commonWidgets/common_widgets.dart';
import '../../utils/utils.dart';

@RoutePage()
class AddVehicleAndDriverDocumentsPage extends StatefulWidget {
  const AddVehicleAndDriverDocumentsPage({super.key, this.isDriverPageOpen = false});
  final bool? isDriverPageOpen;

  @override
  State<AddVehicleAndDriverDocumentsPage> createState() => _AddVehicleAndDriverDocumentsPageState();
}

class _AddVehicleAndDriverDocumentsPageState extends State<AddVehicleAndDriverDocumentsPage> {
  bool? rcDeleted = false;
  bool? insuranceDeleted = false;
  bool? permitDeleted = false;
  bool? fcDeleted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorData.appSecondaryColor,
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          foregroundColor: AppColorData.appSecondaryColor,
          elevation: 0.9,
          pinned: true,
          floating: true,
          expandedHeight: 100,
          backgroundColor: AppColorData.appSecondaryColor,
          flexibleSpace: CommonSliverAppBar(
            title: (widget.isDriverPageOpen == true)?Strings.addDriverDocTitle:Strings.addVehicleDocTitle,
          ),
          centerTitle: false,
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Text(
              "Upload your Document details",
              style: TextStyle(
                fontSize: 16,
                color: AppColorData.grey03,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          spacer(),
          uploadCard(
              btnName: (widget.isDriverPageOpen == true)?"Owner Address Proof": "Tax Registration Certificate (RC)",
              type: "pdf",
              isFileNotAdded: rcDeleted,
              dltOnTap: () {
                print("eeeeeeee");
                setState(() {
                  rcDeleted = true;
                });
              },
              onTap: () {
                if(rcDeleted == true) {
                  context.router.push( DocUploadRoute(isDriverPage: widget.isDriverPageOpen));
                }
              }),
          spacer(),
          uploadCard(
              btnName:  (widget.isDriverPageOpen == true)?"Driver Address Proof":"Taxi Insurance",
              isFileNotAdded: insuranceDeleted,
              dltOnTap: () {
                setState(() {
                  insuranceDeleted = true;
                });
              },
              onTap: () {
                if(insuranceDeleted == true) {
                  context.router.push( DocUploadRoute(isDriverPage: widget.isDriverPageOpen));
                }
              }),
          spacer(),
          uploadCard(
              btnName:  (widget.isDriverPageOpen == true)?"Driving License":"Taxi Permit",
              type: "pdf",
              isFileNotAdded: permitDeleted,
              dltOnTap: () {
                setState(() {
                  permitDeleted = true;
                });
              },
              onTap: () {
                if(permitDeleted == true){
                  context.router.push( DocUploadRoute(isDriverPage: widget.isDriverPageOpen));
                }

              }),
          spacer(),
              (widget.isDriverPageOpen == true)? SizedBox.shrink():uploadCard(
              btnName: "Taxi Fitness Certificate",
              isFileNotAdded: fcDeleted,
              dltOnTap: () {
                setState(() {
                  fcDeleted = true;
                });
              },
              onTap: () {
                if(fcDeleted == true) {
                  context.router.push( DocUploadRoute(isDriverPage: widget.isDriverPageOpen));
                }
              }),
          spacer(),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
            child: CommonElevatedButton(
              height: 60,
              elevatedButtonName: (rcDeleted == true ||
                      insuranceDeleted == true ||
                      permitDeleted == true ||
                      fcDeleted == true)
                  ? Strings.upload
                  : Strings.backToHome,
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                print("object else");
              },
            ),
          ),
        ]))
      ]),
    );
  }

  Widget spacer() {
    return const SizedBox(
      height: 15,
    );
  }

  Widget uploadCard(
      {Function()? onTap,
      required String btnName,
      String? type = "img",
      bool? isFileNotAdded = false,
      Function()? dltOnTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: GestureDetector(
        onTap: onTap,
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(15),
          dashPattern: [5, 5],
          color: AppColorData.dottedBorderColor,
          strokeWidth: 1,
          child: Container(
            decoration: BoxDecoration(
                color: AppColorData.appPrimaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: (isFileNotAdded == true)
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      (isFileNotAdded == true)
                          ? SvgPicture.asset(SVGAssets.file_upload_icon)
                          : Container(
                              height: 50,
                              width: 40,
                              child: SvgPicture.asset((type == "img")
                                  ? SVGAssets.jpg_icon
                                  : SVGAssets.pdf_icon),
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        (isFileNotAdded == true)
                            ?"${Strings.upload} $btnName":btnName,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColorData.docNameColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                (isFileNotAdded == true)
                    ? const SizedBox.shrink()
                    : GestureDetector(
                        onTap: dltOnTap,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            SvgPicture.asset(SVGAssets.remove_icon),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Remove file",
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColorData.appPrimaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                (isFileNotAdded == true)
                    ? const SizedBox.shrink()
                    : const SizedBox(
                        height: 8,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
