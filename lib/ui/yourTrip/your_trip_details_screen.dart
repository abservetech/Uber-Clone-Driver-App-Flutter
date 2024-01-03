import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rebustar_driver/ui/yourTrip/trip_invoice_bottomsheet.dart';
import '../../commonWidgets/common_widgets.dart';
import '../../utils/utils.dart';

@RoutePage()
class TripDetailsPage extends StatefulWidget {
  const TripDetailsPage({super.key, this.showTripCanceledDetails = false});

  final bool? showTripCanceledDetails;

  @override
  State<TripDetailsPage> createState() => _TripDetailsPageState();
}

class _TripDetailsPageState extends State<TripDetailsPage> {
  @override
  Widget build(BuildContext context) {
    print(
        "widget.showTripCanceledDetails :: ${widget.showTripCanceledDetails}");
    return (widget.showTripCanceledDetails == true)
        ? tripCanceledWidget()
        : tripCompletedWidget();
  }

  Widget tripCompletedWidget() {
    return Scaffold(
        // resizeToAvoidBottomInset: true,
        backgroundColor: AppColorData.appSecondaryColor,
        appBar: CommonAppBar(
          backgroundColor: AppColorData.appSecondaryColor,
          titleText: Strings.tripDetails,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          children: [
            tripDetailsCardWidget(
                userName: "Ann Siphron",
                fromAddress: "Vakil New street, Simmakkal, Madurai",
                toAddress: "Vakil New street, Simmakkal, Madurai",
                carType: "Sedan",
                paymentType: "Cash",
                paidAmount: "\$25.00",
                totalAmount: "\$25.00",
                tripStatus: "completed"),
            SizedBox(
              height: 10,
            ),
            buttonsWidget(),
            SizedBox(
              height: 10,
            ),
          ],
        ));
  }

  Widget tripCanceledWidget() {
    return DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.9,
        minChildSize: 0.8,
        expand: false,
        builder: (context, scrollController) => Container(
              decoration: BoxDecoration(
                  color: AppColorData.appSecondaryColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Stack(
                  children: [
                    Container(
                      color: AppColorData.transparent,
                      child: ListView(
                        controller: scrollController,
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            color: Colors.transparent,
                          ),
                          Center(child: SvgPicture.asset(SVGAssets.tripCanceledPost)),
                          tripDetailsCardWidget(
                              userName: "Ann Siphron",
                              fromAddress: "Vakil New street, Simmakkal, Madurai",
                              toAddress: "Vakil New street, Simmakkal, Madurai",
                              carType: "Sedan",
                              paymentType: "Cash",
                              paidAmount: "\$25.00",
                              totalAmount: "\$25.00",
                              tripStatus: "Cancelled"),
                          Container(
                            height: 10,
                            width: 10,
                            color: Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 14,
                      right: 0.0,
                      child: GestureDetector(
                        onTap: () {
                          context.router.pop();
                        },
                        child: Container(
                          height: 32,
                          width: 32,
                          color: Colors.transparent,
                          child: SvgPicture.asset(SVGAssets.cancelBtn),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  Widget tripDetailsCardWidget(
      {String? mapImage,
      String? profileImg,
      String? userName,
      String? fromAddress,
      String? toAddress,
      String? totalAmount,
      String? tripStatus,
      String? carType,
      String? paymentType,
      String? paidAmount}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColorData.appSecondaryColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColorData.white02),
      ),
      child: Column(
        children: [
          (widget.showTripCanceledDetails == true)
              ? SizedBox.shrink()
              : Container(
                  height: 190,
                  decoration: BoxDecoration(
                      color: AppColorData.transparent,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage(mapImage ?? PNGAssets.tripDetails),
                          fit: BoxFit.fill)),
                ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  color: AppColorData.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: SvgPicture.asset(
                        profileImg ?? SVGAssets.emptyProfileImg),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(userName ?? '',
                    style: TextStyle(
                        color: AppColorData.appPrimaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 19))
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Divider(
            color: AppColorData.white02,
            height: 1,
            thickness: 1,
            endIndent: 2,
            indent: 2,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: locationFromToShowWidget(
                fromAddress: fromAddress, toAddress: toAddress),
          ),
          const SizedBox(
            height: 20,
          ),
          Divider(
            color: AppColorData.white02,
            height: 1,
            thickness: 1,
            endIndent: 2,
            indent: 2,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: textAndWidgets(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                prefixText: Strings.bill,
                suffixText: totalAmount ?? '--'),
          ),
          const SizedBox(
            height: 20,
          ),
          Divider(
            color: AppColorData.white02,
            height: 1,
            thickness: 1,
            endIndent: 2,
            indent: 2,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: textAndWidgets(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                prefixText: carType ?? '',
                suffixText: tripStatus ?? ''),
          ),
          const SizedBox(
            height: 20,
          ),
          Divider(
            color: AppColorData.white02,
            height: 1,
            thickness: 1,
            endIndent: 2,
            indent: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: textAndWidgets(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                prefixText: Strings.paymentMode,
                suffixText: ""),
          ),
          //const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: ListTile(
              minLeadingWidth: 10,
              contentPadding: const EdgeInsets.all(0),
              leading: SvgPicture.asset(SVGAssets.money),
              title: Text(paymentType ?? '',
                  style: TextStyle(
                      color: AppColorData.appPrimaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 17)),
              trailing: Text(paidAmount ?? '',
                  style: TextStyle(
                      color: AppColorData.appPrimaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 17)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: CommonElevatedButton(
              height: 60,
              elevatedButtonName: Strings.fareDetailsButton,
              onTap: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  enableDrag: true,
                  backgroundColor: AppColorData.appSecondaryColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  builder: (context) => const TripInvoiceBottomSheet(),
                );
              }),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 2,
          child: CommonElevatedButton(
              height: 60,
              elevatedButtonName: Strings.invoiceButton,
              onTap: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  enableDrag: true,
                  backgroundColor: AppColorData.appSecondaryColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  builder: (context) =>
                      const TripInvoiceBottomSheet(isSendInvoice: true),
                );
              }),
        )
      ],
    );
  }

  Widget locationFromToShowWidget({String? fromAddress, String? toAddress}) {
    return Column(
      children: [
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
                child:
                    CommonDashedLine(color: AppColorData.dotColor, height: 2)),
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
    );
  }

  Widget textAndWidgets(
      {String? prefixText,
      String? suffixText,
      bool? isPrefixWidget = false,
      Widget? prefixWidget,
      double? width,
      Widget? suffixWidget,
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
                    suffixText ?? '', //maxLines: 1,
                    style: TextStyle(
                        // overflow: TextOverflow.ellipsis,
                        color: AppColorData.appPrimaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                )
            : Text(
                suffixText ?? '',
                style: TextStyle(
                    color: AppColorData.appPrimaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              ),
      ],
    );
  }
}
