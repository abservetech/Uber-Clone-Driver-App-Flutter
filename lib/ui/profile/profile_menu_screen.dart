import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rebustar_driver/ui/DocumentUpload/varification_screen.dart';
import '../../commonWidgets/common_widgets.dart';
import '../../routes/router_pages.gr.dart';
import '../../utils/utils.dart';
import '../../commonWidgets/custom_dropdown_container.dart';

@RoutePage()
class ProfileMenuPage extends StatefulWidget {
  const ProfileMenuPage({super.key});

  @override
  State<ProfileMenuPage> createState() => _ProfileMenuPageState();
}

class _ProfileMenuPageState extends State<ProfileMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorData.appSecondaryColor,
      appBar: CommonAppBar(
          backgroundColor: AppColorData.transparent,
          titleText: "",
          isLeadingWidget: true,
          leading: IconButton(
            icon: Icon(Icons.close,
                color: AppColorData.appPrimaryColor, weight: 23),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: renderBody(),
    );
  }

  Widget renderBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Column(
        children: [
          profileWidget(),
          profileMenuWidget(),
          const Spacer(),
          CommonElevatedButton(
            height: 60,
            elevatedButtonName: Strings.logoutText,
            onTap: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationPage(),));
              /*showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                enableDrag: true,
                backgroundColor: AppColorData.appSecondaryColor,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                builder: (context) => logOutBottomSheet(),
              );*/
            },
          ),
        ],
      ),
    );
  }

  Widget profileWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: AppColorData.transparent,
          child: Hero(
            tag: "profile",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CircleAvatar(
                radius: 28,
                foregroundColor: AppColorData.transparent,
                backgroundColor: AppColorData.transparent,
                child: Container(
                  color: AppColorData.transparent,
                  child: SvgPicture.asset(SVGAssets.emptyProfileImg),
                ),
              ),
            ),
          ),
        ),
        Container(
          color: AppColorData.transparent,
          height: 14,
        ),
        Text(
          "Emerson Levin",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: AppColorData.textColor,
              fontWeight: FontWeight.w700,
              fontSize: 30),
        ),
        Container(
          color: AppColorData.transparent,
          height: 14,
        ),
        Text(
          "emerson.levin@gmail.com",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: AppColorData.grey03,
              fontWeight: FontWeight.normal,
              fontSize: 20),
        ),
        Container(
          color: AppColorData.transparent,
          height: 14,
        ),
      ],
    );
  }

  Widget profileMenuWidget() {
    return Container(
      decoration: BoxDecoration(
          color: AppColorData.appSecondaryColor,
          border: Border.all(color: AppColorData.dividerColor),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          GestureDetector(
              onTap: () {
                context.router.push(ProfileEditRoute());
              },
              child: menuCardWidget(
                  leadingIcon: SVGAssets.myProfileMenu,
                  titleText: Strings.profileMenu)),
          commonDivider(),
          GestureDetector(
              onTap: () {
                context.router.push(YourTripListRoute());
              },
              child: menuCardWidget(
                  leadingIcon: SVGAssets.trip_icon,
                  titleText: Strings.tripMenu)),
          commonDivider(),
          GestureDetector(
              onTap: () {
                  context.router.push(RatingsRoute());
                // Navigator.push(context,MaterialPageRoute(builder: (context) => InviteFriendsPage(),));
              },
              child: menuCardWidget(
                  leadingIcon: SVGAssets.ratings_icon,
                  titleText: Strings.ratingsMenu)),
          commonDivider(),
          GestureDetector(
              onTap: () {
                context.router.push(ManageVehiclesListRoute());
              },
              child: menuCardWidget(
                  leadingIcon: SVGAssets.manage_vehicle_icon,
                  titleText: Strings.manageVehicleMenu)),
          commonDivider(),
          GestureDetector(
              onTap: () {
                  context.router.push(AddVehicleAndDriverDocumentsRoute(isDriverPageOpen: true));
              },
              child: menuCardWidget(
                  leadingIcon: SVGAssets.document_icon,
                  titleText: Strings.manageDocMenu)),
        ],
      ),
    );
  }

  Widget commonDivider() {
    return Divider(
      color: AppColorData.dividerColor,
      height: 00,
      thickness: 1,
      endIndent: 10,
      indent: 10,
    );
  }

  Widget menuCardWidget(
      {required String leadingIcon,
      required String titleText,
      Color? txtColor,
      Color? iconColor}) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: -1, vertical: -1),
      minLeadingWidth: 10,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      title: Text(titleText,
          style: TextStyle(
              color: txtColor ?? AppColorData.appPrimaryColor,
              fontWeight: FontWeight.w400,
              fontSize: 17)),
      leading: SvgPicture.asset(
        leadingIcon,
      ),
      trailing: Icon(Icons.arrow_forward_ios_outlined,
          color: iconColor ?? AppColorData.grey03, size: 14),
    );
  }

  Widget logOutBottomSheet() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
            height: 15,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(Strings.logoutText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColorData.appPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                )),
          ),
          Container(
            color: Colors.transparent,
            height: 30,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(Strings.logOutBody,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColorData.grey05,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )),
          ),
          Container(
            color: Colors.transparent,
            height: 30,
          ),
          buttonsWidget(),
          Container(
            color: Colors.transparent,
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget buttonsWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: CommonElevatedButton(
                height: 60,
                elevatedButtonName: Strings.cancel,
                elevatedButtonColor: AppColorData.appSecondaryColor,
                elevatedButtonNameColor: AppColorData.appPrimaryColor,
                border: Border.all(color: AppColorData.appPrimaryColor),
                onTap: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  context.router.pop();
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => CheckInternet(),));
                }),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 2,
            child: CommonElevatedButton(
                height: 60,
                elevatedButtonName: Strings.confirm,
                onTap: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  context.router.pop();
                }),
          )
        ],
      ),
    );
  }
}
