import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rebustar_driver/routes/router_pages.gr.dart';
import '../../commonWidgets/common_widgets.dart';
import '../../utils/utils.dart';

@RoutePage()
class NameRegisterPage extends StatefulWidget {
  const NameRegisterPage({super.key, this.userId});

  final int? userId;

  @override
  State<NameRegisterPage> createState() => _NameRegisterPageState();
}

class _NameRegisterPageState extends State<NameRegisterPage> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AppValidators validators = AppValidators();
  int selectedTextField = -1;
  String? firstNameErrorMessage;
  String? lastNameErrorMessage;

  @override
  void initState() {
    selectedTextField = -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: floatingActionWidget(),
        appBar: CommonAppBar(
          backgroundColor: AppColorData.transparent,
          isLeadingWidget: true,
          leading: IconButton(
            icon: Icon(Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back,
                color: AppColorData.appPrimaryColor, weight: 23),
            onPressed: () {
              print("back pressed");
              Navigator.pop(context);
            },
          ),
        ),
        body: renderBody());
  }

  Widget renderBody() {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),
          textWidget(isSubText: false, text: Strings.nameTitle),
          const SizedBox(height: 10),
          textWidget(isSubText: true, text: Strings.nameSubText),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textFromField(
                    onTap:(){
                      setState(() {
                        selectedTextField = 0;
                      });
                    },
                    controller: firstName,
                    errorText:  firstNameErrorMessage,
                    labelText: Strings.firstNameLabel,
                isSelected: (selectedTextField == 0)? true: false),
                textFromField(
                    onTap:(){
                      setState(() {
                        selectedTextField = 1;
                      });
                    },
                    controller: lastName,
                    errorText:  lastNameErrorMessage,
                    labelText: Strings.lastNameLabel,
                    isSelected: (selectedTextField == 1)? true: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget textWidget({String? text, required bool isSubText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text ?? '',
          style: (isSubText != true)
              ? TextStyle(
                  color: AppColorData.textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 30)
              : TextStyle(
                  height: 1.4,
              color: AppColorData.grey03,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
        ),
      ),
    );
  }

  Widget textFromField({Function()?  onTap,
    bool? isSelected = false,
    TextEditingController? controller,
    String? labelText,
    String? errorText,}){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: CommonTextFromField(
            onTap: onTap,
            width: MediaQuery.of(context).size.width * 0.43,
            border: Border.all(color: (errorText == null) ?(isSelected == true)? AppColorData.appPrimaryColor:AppColorData.transparent : AppColorData.errorColor,),
            keyboardType: TextInputType.text,
            controller:controller,
            fillColor: (isSelected == true) ? AppColorData.appSecondaryColor : AppColorData.white02,
            labelText: labelText,
            contentPadding: const EdgeInsets.symmetric( horizontal: 14),
          ),
        ),
        (errorText != null)?
        Row(
          children: [
            SvgPicture.asset(SVGAssets.error_icon),
            const SizedBox(width: 10,),
            Text(errorText??'',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColorData.errorColor
              ),),
          ],
        ):const SizedBox.shrink()
      ],
    );
  }

  Widget floatingActionWidget() {
    return FloatingActionButton(
        backgroundColor: AppColorData.appPrimaryColor,
        child: Icon(
          Icons.arrow_forward,
          color: AppColorData.appSecondaryColor,
        ),
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          setState(() {
            firstNameErrorMessage = validators.validateName(firstName.text, false);
            lastNameErrorMessage = validators.validateName(lastName.text, false);
          });
          Logger.appLogs("Next button clicked");
          if (formKey.currentState!.validate()) {
            Logger.appLogs("Next button clicked 1 :firstNameErrorMessage :$firstNameErrorMessage");
            if(firstNameErrorMessage == null && lastNameErrorMessage == null) {
              Logger.appLogs("Next button clicked 2");
              Map<String, dynamic> param = {
                'id': widget.userId,
                'username': "${firstName.text} ${lastName.text}",
                'page': 'step3'
              };
              context.router.push(const GenderSelectRegisterRoute());
            }
          }
        });
  }
}
