import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rebustar_driver/routes/router_pages.gr.dart';
import 'package:toast/toast.dart';

import '../../commonWidgets/common_widgets.dart';
import '../../utils/utils.dart';


@RoutePage()
class GenderSelectRegisterPage extends StatefulWidget {
  const GenderSelectRegisterPage({super.key});

  @override
  State<GenderSelectRegisterPage> createState() => _GenderSelectRegisterPageState();
}

class _GenderSelectRegisterPageState extends State<GenderSelectRegisterPage> {
  int selectedGenderIndex = -1;
  String? selectedGenderType = '';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20),
        textWidget(isSubText: false, text: Strings.genderTitle),
        const SizedBox(height: 10),
        textWidget(isSubText: true, text: Strings.genderSubText),
        const SizedBox(height: 20),
         Wrap(
           alignment: WrapAlignment.center,
           //mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             genderCardWidget(
                 image: SVGAssets.male_icon,
                 name: Strings.male,
                 isSelected: (selectedGenderIndex == 0)? true:false,
                 onTap:(){
                   setState(() {
                     selectedGenderIndex = 0;
                     selectedGenderType = Strings.male;
                   });
                 } ),
             genderCardWidget(
               image: SVGAssets.female_icon,
               name: Strings.female,
               isSelected: (selectedGenderIndex == 1)? true:false,
                 onTap:(){
                   setState(() {
                     selectedGenderIndex = 1;
                     selectedGenderType = Strings.female;
                   });
                 }
             ),
             genderCardWidget(
               image: SVGAssets.trans_icon,
               name: Strings.trans,
                 isSelected: (selectedGenderIndex == 2)? true:false,
                 onTap:(){
                   setState(() {
                     selectedGenderIndex = 2;
                     selectedGenderType = Strings.trans;
                   });
                 })
           ],
         ),
      ],
    );
  }

  Widget genderCardWidget({required String image,required String name,bool? isSelected,Function()? onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: AppColorData.appSecondaryColor,
        elevation: 4,

        margin: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: AnimatedContainer(
          height: 110,width: 110,
          decoration: BoxDecoration(
            color: AppColorData.appSecondaryColor,
            border: Border.all(
              color: (isSelected == true)?AppColorData.appPrimaryColor:AppColorData.transparent,
              width: 1.2
            ),
            borderRadius: BorderRadius.circular(20)
          ),
          duration: Duration(milliseconds: 200),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(image),
              Center(
                child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    )
                ),
              )
            ],
          ),
        ),
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

  Widget floatingActionWidget() {
    return FloatingActionButton(
        backgroundColor: AppColorData.appPrimaryColor,
        child: Icon(
          Icons.arrow_forward,
          color: AppColorData.appSecondaryColor,
        ),
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          Logger.appLogs("Next button clicked selectedGenderType :: $selectedGenderType");
          if(selectedGenderType != null && selectedGenderType != ''){
            context.router.push(GmailRegisterRoute(isForgotPasswordProcess: false,id: 1));
          }
          else{
            ToastContext().init(context);
            ToastUtil.showSnackBar(
                context, "Please select gender");
          }
            //context.router.push(GmailRegisterRoute(isForgotPasswordProcess: false));
        });
  }
}

