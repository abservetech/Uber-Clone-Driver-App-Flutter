import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../commonWidgets/common_widgets.dart';
import '../../routes/router_pages.gr.dart';
import '../../utils/utils.dart';

@RoutePage()
class GmailRegisterPage extends StatefulWidget {
  const GmailRegisterPage({super.key, this.isForgotPasswordProcess, this.id});

  final bool? isForgotPasswordProcess;
  final int? id;

  @override
  State<GmailRegisterPage> createState() => _GmailRegisterPageState();
}

class _GmailRegisterPageState extends State<GmailRegisterPage> {
  TextEditingController mailInput = TextEditingController();
  final GlobalKey<FormState> mailFormKey = GlobalKey<FormState>();
  AppValidators validators = AppValidators();
  int selectedTextField = -1;
  String? errorMessage;

  @override
  void initState() {
    selectedTextField = -1;
    super.initState();
    if (widget.isForgotPasswordProcess == true) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionWidget(),
      appBar: CommonAppBar(
        backgroundColor: AppColorData.transparent,
        elevation: 0,
      ),
      body: renderBody()
    );
  }
Widget renderBody(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        textWidget(isSubText: false,text: Strings.mailTitle),
        const SizedBox(height: 10),
        textWidget(isSubText: true,text: Strings.mailSubText),
        const SizedBox(height: 20),
        textFromField(
          onTap: (){
            setState(() {
              selectedTextField = 0;
            });
          },
          isSelected: (selectedTextField == 0)? true: false,
          labelText: Strings.mailLabel,
          controller: mailInput,
          errorText: errorMessage
        )
      ],
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
        // backgroundColor: AppColorData.appPrimaryColor,
        child: Icon(
          Icons.arrow_forward,
          color: AppColorData.appSecondaryColor,
        ),
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          setState(() {
            errorMessage = validators.validateEmail(mailInput.text);
          });
          Logger.appLogs("Next button clicked");
          if (errorMessage == null) {
           if(widget.isForgotPasswordProcess == true){
               print("Send OTP button clicked");
               Map<String, dynamic> forgotPassParam;
               PreferenceHelper.setString(
                   PrefConstant.email, mailInput.text);
               forgotPassParam = {
                 "page": "step1",
                 "email": mailInput.text,
               };
               context.router.push(OtpRoute(isForgotPasswordPage: true,otpToken: 1234,userId: 1,type: "step_2"));
           }
           else{
             print("Send OTP button clicked");
             Map<String, dynamic> param;
             PreferenceHelper.setString(
                 PrefConstant.email, mailInput.text);
             param = {
               'id': widget.id,
               "page": "step4",
               "email": mailInput.text,
             };
             context.router.push(OtpRoute(isForgotPasswordPage: false,otpToken: 1234,userId: 1,type: "step_2"));
           }
          }
        });
  }

  Widget textFromField({Function()?  onTap,
    bool? isSelected = false,
    TextEditingController? controller,
    String? labelText,
    String? errorText,}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonTextFromField(
            onTap: onTap,
            border: Border.all(color: (errorText == null) ?(isSelected == true)? AppColorData.appPrimaryColor:AppColorData.transparent : AppColorData.errorColor,),
            keyboardType: TextInputType.emailAddress,
            controller:controller,
            fillColor: (isSelected == true) ? AppColorData.appSecondaryColor : AppColorData.white02,
            labelText: labelText,
            contentPadding: const EdgeInsets.symmetric( horizontal: 14),
          ),
          const SizedBox(height: 4,),
          (errorText != null)?
          Row(
            children: [
              SvgPicture.asset(SVGAssets.error_icon),
              const SizedBox(width: 10,),
              Text(errorText,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColorData.errorColor
                ),),
            ],
          ):const SizedBox.shrink()
        ],
      ),
    );
  }
}
