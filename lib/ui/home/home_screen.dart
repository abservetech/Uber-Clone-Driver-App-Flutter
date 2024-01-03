import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show SystemChannels, rootBundle;
import 'package:rebustar_driver/ui/home/online_ofline_bottom_sheet.dart';
import 'package:rebustar_driver/ui/home/trip_request_bottom_sheet.dart';
import 'package:toast/toast.dart';

import '../../commonWidgets/common_widgets.dart';
import '../../routes/router_pages.gr.dart';
import '../../utils/utils.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key, this.currentLong, this.currentLat});
  final  double? currentLong;
  final  double? currentLat;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller = Completer();
  List<LatLng> polylineCoordinates = [];
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  CameraPosition? cameraPosition;
  String? _mapStyle;
  DefaultTabController? tabController;
  bool? isOffline = true;
  bool? isShowTripAlertSheet = false;

  DateTime? backbuttonpressedTime;

  double? lat;
  double? long;
  String pinningAddress = "";
  final CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void setState(void Function() fn);
  @override
  void initState() {
    lat = widget.currentLat;
    long = widget.currentLong;
    setCustomMarkerIcon();
    getCurrentLocation();
   // getUserName();

    print(
        "widget.currentLocation ::${widget.currentLat} and \n currentLocation :: ${widget.currentLong}");
    rootBundle.loadString(FileAssets.mapStyle).then((string) {
      _mapStyle = string;
    });
    super.initState();
  }
  Future<void> getUserName() async {
    isShowTripAlertSheet = await PreferenceHelper.getBool(PrefConstant.showOnlineButton);
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        backgroundColor: AppColorData.appSecondaryColor,
        appBar: CommonAppBar(
          backgroundColor: AppColorData.transparent,
          titleText: "",
          isLeadingWidget: true,
          leading: profileWidget(),
        ),
        body: renderBody(),
      ),
    );
  }

  Widget renderBody() {
    return Stack(
      children: [
        (lat == null && long == null)
            ? const Loader()
            : GoogleMap(
                compassEnabled: false,
                buildingsEnabled: true,
                zoomGesturesEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat??widget.currentLat!, long??widget.currentLong!),
                  zoom: 14,
                ),
                onTap: (position){
                 // _customInfoWindowController.hideInfoWindow!();
                  },
                onCameraIdle: () async {
                  List<Placemark> placeMarks = await placemarkFromCoordinates(
                      cameraPosition?.target.latitude ?? lat ?? widget.currentLat!,
                      cameraPosition?.target.longitude ?? long ?? widget.currentLong!);
                  setState(() {
                    pinningAddress = "${placeMarks.first.name},${placeMarks.first.thoroughfare!.isEmpty
                            ? ""
                            : "${placeMarks.first.thoroughfare},"}${placeMarks.first.locality},${placeMarks.first.postalCode},${placeMarks.first.administrativeArea},${placeMarks.first.country}. ";
                     Logger.appLogs("lat::$lat lan:: $long");
                  });
                },
                mapType: MapType.normal,
                onCameraMove: (CameraPosition cameraPositions) {
                  _customInfoWindowController.onCameraMove!();
                 // cameraPosition = cameraPositions;
                },
                onMapCreated: (mapController) {
                  _customInfoWindowController.googleMapController = mapController;
                  mapController.setMapStyle(_mapStyle);
                  //_controller.complete(mapController);
                },
                      markers: {
            Marker(
              onTap:(){
                print("ontap");
                _customInfoWindowController.addInfoWindow!(
                  Container(
                    color: AppColorData.transparent,
                    height: 40,
                    width: 150,
                    child: Column(
                      children: [
                        Container(
                          color: AppColorData.appSecondaryColor,
                          height: 40,
                          width: 150,
                          child: Text(pinningAddress,
                              maxLines: 2,
                              style: const TextStyle(
                                  fontSize: 14, overflow: TextOverflow.ellipsis)),
                        ),
                      ],
                    ),
                  ),
                LatLng(lat!, long!),
                );

              },
                markerId: const MarkerId("source"),
                icon: sourceIcon,
                position:  LatLng(lat!, long!),
            ),
                      },
              ),
        CustomInfoWindow(
          controller: _customInfoWindowController,
          height: 40,
          width: 150,
          offset: 50,
        ),
        (isShowTripAlertSheet == true)? SizedBox.shrink():driverOnlineButtonWidget(),
        Positioned(
          bottom: 0.0,
          right: 0.0,
          left: 0.0,
          child:OnlineOfflineBottomSheet(isOnline: isOffline),
        ),

      ],
    );
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, PNGAssets.locationMarker)
        .then(
          (icon) {
        sourceIcon = icon;
      },
    );
  }

  onCameraIdle(){

  }

  Widget profileWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Hero(
        tag: "profile",
        child: GestureDetector(
          onTap: (){
           /* locationBottomSheet(context: context,validFun: (){
              context.router.push(const ProfileMenuRoute());
              Logger.appLogs("Next button clicked");
            });*/
            context.router.push(const ProfileMenuRoute());
          },
          child:
          Container(
            height: 40,width: 40,
            color: AppColorData.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: SvgPicture.asset(
                  SVGAssets.emptyProfileImg
              ),
            ),
          )
        ),
      ),
    );
  }

  Widget driverOnlineButtonWidget(){
    return  Positioned(
        bottom: 170.0,
        right: 0.0,
        left: 0.0,
        child:
        Center(
            child: GestureDetector(
              onTap: (){
                setState(() {
                  isOffline = !isOffline!;
                });

                Timer(Duration(seconds: 4), () {
                  setState(() {
                    isShowTripAlertSheet = true;
                  });
                  PreferenceHelper.setBool(PrefConstant.showOnlineButton, isShowTripAlertSheet!);
                  if(isOffline == false) {
                    showModalBottomSheet(
                        context: _scaffoldKey.currentContext ?? context,
                        backgroundColor: AppColorData.appSecondaryColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                        enableDrag: false,
                        isDismissible: false,
                        builder: (context) =>
                            TripAlertBottomSheet(
                              context: _scaffoldKey.currentContext ?? context,
                              acceptOnTap: () {},
                              cancelOnTap: () {
                                setState(() {
                                  isShowTripAlertSheet = false;
                                });
                                context.router.pop();
                              },
                            )
                    );
                  }
                });

                print("isOffline :: $isOffline");
              },
              child: CircleAvatar(
                  backgroundColor: AppColorData.appPrimaryColor,
                  foregroundColor: AppColorData.appPrimaryColor,
                  maxRadius: 35,
                  child:  CircleAvatar(
                    backgroundColor: AppColorData.appSecondaryColor,
                    foregroundColor: AppColorData.appSecondaryColor,
                    maxRadius: 30,
                    child: CircleAvatar(
                      backgroundColor: (isOffline == true)? AppColorData.appSecondaryColor :AppColorData.appPrimaryColor,
                      foregroundColor: (isOffline == true)? AppColorData.appSecondaryColor : AppColorData.appPrimaryColor,
                      maxRadius: 28,
                      child: Text(
                          (isOffline == true)?  Strings.goOnline : Strings.goOffline,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:(isOffline == true)? AppColorData.appPrimaryColor:AppColorData.appSecondaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )
                      ),
                    ),
                  )
              ),
            )
        )
    );
  }

  Future<bool> _onWillPop() async {
    DateTime currentTime = DateTime.now();
    bool backButton = backbuttonpressedTime == null ||
        currentTime.difference(backbuttonpressedTime!) >
            const Duration(seconds: 3);
    if (backButton) {
      backbuttonpressedTime = currentTime;
      ToastContext().init(context);
      ToastUtil.showSnackBar(context, Strings.pressBackAgain);
      return false;
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return true;
  }

  void getCurrentLocation() async {
      Geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high, forceAndroidLocationManager: true)
          .then((Position position) {
            print("position.latitude :: ${position.latitude}");
        setState(() {
          lat = position.latitude;
          long = position.longitude;
          Logger.appLogs("lat:: dsf $lat lan::  wef $long");
        });
      }).catchError((e) {
        print("error :::: $e");
      });

  }

}

