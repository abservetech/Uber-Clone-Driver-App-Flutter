import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rebustar_driver/routes/router_pages.gr.dart';
import 'package:rebustar_driver/ui/yourTrip/your_trip_details_screen.dart';
import '../../../../utils/utils.dart';
import '../../commonWidgets/common_widgets.dart';

@RoutePage()
class YourTripListPage extends StatefulWidget {
  const YourTripListPage({super.key});

  @override
  State<YourTripListPage> createState() => _YourTripListPageState();
}

class _YourTripListPageState extends State<YourTripListPage> {
  bool isListEmpty = true;
  int? selectedRadio;
  bool isCanceledTripIndex = false;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
    context.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            foregroundColor: AppColorData.appSecondaryColor,
            elevation: 0.9,
            pinned: true,
            floating: true,
            expandedHeight: 100,
            backgroundColor: AppColorData.appSecondaryColor,
            flexibleSpace: const CommonSliverAppBar(
              title: Strings.tripMenu,
            ),
            centerTitle: false,
            actions: [
              Switch.adaptive(
                trackOutlineWidth: const MaterialStatePropertyAll(1),
                trackOutlineColor:
                MaterialStatePropertyAll(AppColorData.appPrimaryColor),
                activeColor: AppColorData.appPrimaryColor,
                activeTrackColor: AppColorData.white02,
                inactiveThumbColor: AppColorData.white02,
                inactiveTrackColor: AppColorData.appSecondaryColor,
                splashRadius: 20.0,
                value: !isListEmpty,
                onChanged: (val){
                  setState(() {
                    isListEmpty = !val;
                  });
                },
              ),
              (isListEmpty == true)
                  ? const SizedBox.shrink()
                  : GestureDetector(
                      onTap: () {
                        print("tessst");
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          enableDrag: true,
                          backgroundColor: AppColorData.appSecondaryColor,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20))),
                          builder: (context) => filterSheetWidget(),
                        );
                      },
                      child: SvgPicture.asset(SVGAssets.filterIcon)),
              const SizedBox(
                width: 14,
              ),
            ],
          ),
          (isListEmpty == true)
              ? SliverList(
                  delegate: SliverChildListDelegate([
                  SizedBox(
                    //height: 20,
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  emptyTripWidget(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                  )
                ]))
              : SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                  isCanceledTripIndex = index % 2 == 0;
                  return yourTripCard(
                      onTap: () {
                        bool isCanceledTripIndex = index % 2 == 0;
                        print("isCanceledTripIndex :: $isCanceledTripIndex");
                        if (isCanceledTripIndex == true) {
                          showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        enableDrag: false,
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.vertical(
                               top: Radius.circular(20)
                             )),
                        backgroundColor: AppColorData.appSecondaryColor,
                        builder: (context) =>  TripDetailsPage(showTripCanceledDetails: isCanceledTripIndex),
                      );
                        } else {
                           context.router.push(TripDetailsRoute(showTripCanceledDetails: isCanceledTripIndex));
                        }
                      },
                      isCanceledTrip: isCanceledTripIndex,
                      amount: "\$${index}25",
                      bookingId: "0$index",
                      date: "0$index-12-2023",
                      fromAddress: "West Maasi street, Central,Madurai.",
                      toAddress: "29,Mahatma Gandhi Nagar,Chennai.",
                      time: "11.5$index");
                }, childCount: 6))
        ],
      ),
    );
  }

  Widget yourTripCard(
      {String? date,
      String? time,
      String? bookingId,
      String? amount,
      String? fromAddress,
      String? toAddress,
      Function()? onTap,
      required bool isCanceledTrip}) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 14.0, right: 14.0, top: 7.0, bottom: 7.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: AppColorData.appSecondaryColor,
            border: Border.all(color: AppColorData.white02),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Card(
            color: AppColorData.appSecondaryColor,
            elevation: 0,
            child: Column(
              children: [
                textAndWidgets(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    prefixText: date ?? '',
                    suffixText: time ?? ''),
                const SizedBox(
                  height: 10,
                ),
                textAndWidgets(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    prefixText: ("${Strings.bookingId}${bookingId ?? ''}"),
                    suffixTextColor: (isCanceledTrip == true)
                        ? AppColorData.red
                        : AppColorData.appPrimaryColor,
                    suffixText: (isCanceledTrip == true)
                        ? Strings.cancelledTripsFilter
                        : (amount ?? '')),
                const SizedBox(
                  height: 20,
                ),
                textAndWidgets(
                    isPrefixWidget: true,
                    width: 10,
                    prefixWidget: SvgPicture.asset(SVGAssets.navigation),
                    suffixText: fromAddress ?? ''),
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
                    suffixText: toAddress ?? ''),
              ],
            ),
          ),
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.74,
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

  Widget emptyTripWidget() {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          SvgPicture.asset(SVGAssets.yourTripEmpty),
          const SizedBox(
            height: 20,
          ),
          Text(
            Strings.emptyTripTitle,
            style: TextStyle(
                color: AppColorData.appPrimaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 19),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            Strings.emptyTripBody,
            textAlign: TextAlign.center,
            style: TextStyle(
                height: 1.5,
                color: AppColorData.appPrimaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 17),
          ),
        ],
      ),
    );
  }

  Widget filterSheetWidget() {
    return Container(
      decoration: BoxDecoration(
          color: AppColorData.appSecondaryColor,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
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
              Container(
                color: Colors.transparent,
                height: 15,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(Strings.tripFilter,
                    style: TextStyle(
                      color: AppColorData.appPrimaryColor,
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    )),
              ),
              Container(
                color: Colors.transparent,
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColorData.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: AppColorData.white02)),
                child: Wrap(
                  children: [
                    filterRadioButtonWidget(
                        value: 1, text: Strings.pastTripsFilter),
                    Divider(
                      color: AppColorData.dividerColor,
                      height: 1,
                      thickness: 1,
                    ),
                    filterRadioButtonWidget(
                        value: 2, text: Strings.upcomingTripsFilter),
                    Divider(
                      color: AppColorData.dividerColor,
                      height: 1,
                      thickness: 1,
                    ),
                    filterRadioButtonWidget(
                        value: 3, text: Strings.cancelledTripsFilter)
                  ],
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 15,
              ),
            ],
          )),
    );
  }

  Widget filterRadioButtonWidget({required int value, String? text}) {
    return Container(
      color: AppColorData.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "  $text",
            style: TextStyle(
                color: AppColorData.appPrimaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
          Radio(
            value: value,
            groupValue: selectedRadio,
            activeColor: AppColorData.appPrimaryColor,
            onChanged: (int? val) {
              Logger.appLogs("Radio $val");
              setState(() {
                setSelectedRadio(val ?? 0);
              });
            },
          ),
        ],
      ),
    );
  }
}