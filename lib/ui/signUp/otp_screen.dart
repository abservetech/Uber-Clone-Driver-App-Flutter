import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:rebustar_driver/routes/router_pages.gr.dart';
import 'package:toast/toast.dart';
import '../../commonWidgets/common_widgets.dart';
import '../../utils/utils.dart';

@RoutePage()
class OtpPage extends StatefulWidget {
  final bool isForgotPasswordPage;
  final String? type;
  final int? otpToken;
  final int? userId;

  const OtpPage(
      {super.key, required this.isForgotPasswordPage, this.otpToken, this.userId, this.type});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  int? otp;

  @override
  void initState() {
    super.initState();
    /*if(widget.isForgotPasswordPage == true){
    }
    else{
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionWidget(),
      appBar: CommonAppBar(backgroundColor: AppColorData.transparent,),
      body: renderBody(),
    );
  }

  Widget renderBody(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20),
        textWidget(
          text: Strings.otpTitle,
         isSubText: false
        ),
        const SizedBox(height: 10),
        textWidget(
            text: Strings.otpSubText,
            isSubText: true
        ),
        const SizedBox(height: 10,),
        Center(child: Text("your otp is :: ${widget.otpToken}")),
        const SizedBox(height: 10,),
        otpWidget()
      ],
    );
  }

  Widget textWidget({String? text,required bool isSubText}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text ?? '',
          style: (isSubText != true)?
          TextStyle(
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

  Widget otpWidget(){ return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Form(
        key: otpFormKey,
        child: OtpPinField(
            key: _otpPinFieldController,
            onSubmit: (text) {
              if (text == "4") {
                Logger.appLogs('Entered pin is $text');

                /// return the entered pin
              }
            },
            onChange: (text) {
              Logger.appLogs('Enter on change pin is $text');
              otp = int.tryParse(text);

              /// return the entered pin
            },
            cursorColor: AppColorData.appPrimaryColor,
            otpPinFieldStyle: OtpPinFieldStyle(
              textStyle: TextStyle(
                color: AppColorData.appPrimaryColor,
                fontSize: 22,
                fontWeight: FontWeight.w700
              ),
                filledFieldBorderColor: AppColorData.appPrimaryColor,
                defaultFieldBorderColor: AppColorData.defaultOtpBorderColor ,
                activeFieldBorderColor: AppColorData.appPrimaryColor),
            maxLength: 4,
            fieldHeight: MediaQuery.of(context).size.height * 0.09,
            fieldWidth: 70,
            otpPinFieldDecoration:
            OtpPinFieldDecoration.defaultPinBoxDecoration),
      ),
    );}

  Widget floatingActionWidget(){
    return FloatingActionButton(
        backgroundColor: AppColorData.appPrimaryColor,
        child: Icon(Icons.arrow_forward,color: AppColorData.appSecondaryColor,),
        onPressed: (){
          if (widget.isForgotPasswordPage == true){
            if (otpFormKey.currentState!.validate()) {
              Map<String, dynamic>
              otpParam = {
                'id': widget.userId,
                'otp_mail_send': otp,
                'page': 'step2',
                'otp': widget.otpToken
              };
              Logger.appLogs(" otp :: ${widget.otpToken} custom type::$otp");
              if (widget.otpToken != otp) {
                ToastContext().init(context);
                ToastUtil.showSnackBar(
                    context, "Please fill correct OTP");
              } else {
                context.router.push(PasswordRoute(isResetPassword: true,id: 1));
              }
            }
          }
          else{
            if (otpFormKey.currentState!.validate()) {
              late Map<String, dynamic> params;
              if (widget.otpToken != otp) {
                ToastContext().init(context);
                ToastUtil.showSnackBar(
                    context, "Please fill correct the OTP");
              } else {
                Logger.appLogs("Verify OTP button clicked");
                if(widget.type == 'step_1'){
                  params = {
                    'id':widget.userId,
                    'phone_token': widget.otpToken,
                    'page':'step2'
                  };
                  context.router.push(NameRegisterRoute(userId: 1));
                } else{
                  params = {
                    'id':widget.userId,
                    'email_token': widget.otpToken,
                    'page':'step5'
                  };
                  context.router.push(PasswordRoute(isResetPassword: false,id: 1));
                }
              }
            }
          }
        });
  }

}
