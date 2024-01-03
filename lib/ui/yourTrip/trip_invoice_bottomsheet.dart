import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../commonWidgets/common_widgets.dart';
import '../../utils/utils.dart';

class TripInvoiceBottomSheet extends StatelessWidget {
  const TripInvoiceBottomSheet({super.key, this.isSendInvoice = false});

  final bool? isSendInvoice;

  @override
  Widget build(BuildContext context) {
    final GlobalKey secondComponentKey = GlobalKey();
    TextEditingController mailInput = TextEditingController();
    AppValidators validators = AppValidators();

    return Container(
      key: secondComponentKey,
      decoration: BoxDecoration(
          color: AppColorData.appSecondaryColor,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      child: Padding(
          padding: EdgeInsets.only(
              left: 14.0,
              right: 14.0,
              top: 14.0,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: (isSendInvoice == true)
              ? sendInvoiceWidget(
                  validators: validators,
                  controller: mailInput,
                  context: context)
              : viewFareDetailsWidget(context)),
    );
  }

  Widget viewFareDetailsWidget(BuildContext context) {
    return Wrap(
      children: [
        Container(
          color: Colors.transparent,
          height: 15,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(Strings.tripInvoice,
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
        Divider(
          color: AppColorData.dividerColor,
          height: 1,
          thickness: 1,
        ),
        invoiceTextWidget(
            context: context, prefixText: "Mile Fare", suffixText: "\$0.00"),
        invoiceTextWidget(
            context: context,
            prefixText: "Booking Fare",
            suffixText: "\$25.00"),
        invoiceTextWidget(
            context: context, prefixText: "Base Fare", suffixText: "\$50.00"),
        invoiceTextWidget(
            context: context, prefixText: "Waiting time", suffixText: "\$0.00"),
        invoiceTextWidget(
            context: context, prefixText: "Pickup Fee", suffixText: "\$0.00"),
        invoiceTextWidget(
            context: context, prefixText: "Tax 0.00%", suffixText: "\$0.00"),
        invoiceTextWidget(
            context: context,
            prefixText: "Cancellation Fare",
            suffixText: "\$0.00"),
        invoiceTextWidget(
            context: context, prefixText: "Time Fare", suffixText: "\$0.00"),
        invoiceTextWidget(
            context: context, prefixText: "Toll Fare", suffixText: "\$0.00"),
        invoiceTextWidget(
            context: context, prefixText: "Total Fare", suffixText: "\$75.00"),
        Container(
          color: Colors.transparent,
          height: 15,
        ),
      ],
    );
  }

  Widget sendInvoiceWidget(
      {TextEditingController? controller,
      required AppValidators validators,
      required BuildContext context}) {
    return Wrap(
      children: [
        Container(
          color: Colors.transparent,
          height: 15,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(Strings.enterEmailAddress,
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
        eMailTextField(validators: validators, controller: controller),
        Container(
          color: Colors.transparent,
          height: 15,
        ),
        buttonsWidget(context),
        Container(
          color: Colors.transparent,
          height: 15,
        ),
      ],
    );
  }

  eMailTextField(
      {TextEditingController? controller, required AppValidators validators}) {
    return CommonTextFromField(
      border: Border.all(color: AppColorData.appPrimaryColor),
      autofocus: true,
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      fillColor: AppColorData.appSecondaryColor,
      labelText: Strings.mailLabel,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      validator: (_) => validators.validateEmail(controller?.text ?? ''),
    );
  }

  Widget buttonsWidget(BuildContext context) {
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
              elevatedButtonName: Strings.cancel,
              onTap: () {
                context.router.pop();
              }),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 2,
          child: CommonElevatedButton(
              height: 60,
              elevatedButtonName: Strings.send,
              onTap: () {
                context.router.pop();
              }),
        )
      ],
    );
  }

  Widget invoiceTextWidget(
      {required BuildContext context, String? prefixText, String? suffixText}) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        textAndWidgets(
            context: context,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            prefixText: prefixText,
            suffixText: suffixText),
        const SizedBox(
          height: 15,
        ),
        Divider(
          color: AppColorData.dividerColor,
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }

  Widget textAndWidgets(
      {required BuildContext context,
      String? prefixText,
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
