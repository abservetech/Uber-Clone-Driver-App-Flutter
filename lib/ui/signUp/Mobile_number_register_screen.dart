import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rebustar_driver/routes/router_pages.gr.dart';
import 'package:toast/toast.dart';
import '../../commonWidgets/common_widgets.dart';
import '../../utils/utils.dart';


@RoutePage()
class MobileNumberRegisterPage extends StatefulWidget {
  const MobileNumberRegisterPage({super.key});

  @override
  State<MobileNumberRegisterPage> createState() => _MobileNumberRegisterPageState();
}

class _MobileNumberRegisterPageState extends State<MobileNumberRegisterPage> {
  final TextEditingController phoneInput = TextEditingController();
  final GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();
  AppValidators validators = AppValidators();
  String? countryCode = 'IN';
  int selectedTextField = -1;
  String? errorMessage;

  @override
  void initState() {
    selectedTextField = -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar( backgroundColor: AppColorData.transparent,),
      floatingActionButton: floatingActionWidget(),
      body: renderBody(),
    );
  }
  Widget renderBody(){
    return Form(
      key: phoneFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),
          headingWidget(),
          const SizedBox(height: 20),
          mobileContentWidget(),

          const SizedBox(height: 20),
          phoneNumberWithCountryTextField(),
          (errorMessage != null)?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0,vertical: 4),
            child: Row(
              children: [
                SvgPicture.asset(SVGAssets.error_icon),
                SizedBox(width: 10,),
                Text(errorMessage??'',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColorData.errorColor
                ),),
              ],
            ),
          ):SizedBox.shrink()
        ],
      ),
    );
  }

  Widget headingWidget(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          Strings.mobileNUmberTitle,
          style: TextStyle(
            height: 0.9,
              color: AppColorData.textColor,
              fontWeight: FontWeight.w600,
              fontSize: 30),
        ),
      ),
    );
  }

  Widget mobileContentWidget(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          Strings.mobileNUmberSubTitle,
          style: TextStyle(
              height: 1.5,
              color: AppColorData.grey03,
              fontWeight: FontWeight.w400,
              fontSize: 14),
        ),
      ),
    );
  }
  Widget number(){
    return CountryCodePicker(
      onChanged: (code){
        setState(() {
          countryCode = code.dialCode;
        });
        Logger.appLogs("countryCode :: $countryCode");
      },

      initialSelection: countryCode,
      dialogBackgroundColor: AppColorData.appSecondaryColor,
      dialogTextStyle: TextStyle(
        color: AppColorData.appPrimaryColor,
        fontSize: 14,
      ),
      dialogSize: Size(MediaQuery.of(context).size.width * 0.9, MediaQuery.of(context).size.height * 0.8),
      padding: const EdgeInsets.all(0),
      textStyle: TextStyle(
        color: AppColorData.grey03,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      searchDecoration: InputDecoration(
        enabled: true,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColorData.appPrimaryColor)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColorData.appPrimaryColor)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColorData.appPrimaryColor)),
        hintText: Strings.search,
        hintStyle: TextStyle(
          color: AppColorData.appPrimaryColor,
          fontSize: 14,
        ),
      ),
      flagDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }

  phoneNumberWithCountryTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 60,//MediaQuery.of(context).size.height * 0.09,
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: AppColorData.white02,
                  borderRadius: BorderRadius.circular(10)),
              child: number()
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 2,
            child: numberFromField(0),
          ),
        ],
      ),
    );
  }

  Widget numberFromField(int index) {
    return CommonTextFromField(
      onTap: () {
        setState(() {
          selectedTextField = index;
        });
      },
      onFieldSubmitted: (value) {
        setState(() {
          errorMessage = validators.validateMobileNumber(value);
        });
        print("errorMessage:: $errorMessage");
      },
      border: Border.all(
        color: (errorMessage == null)? (selectedTextField == index)
            ? AppColorData.appPrimaryColor: AppColorData.transparent
            : AppColorData.errorColor,
      ),
      //height: MediaQuery.of(context).size.height * 0.1,
      keyboardType: TextInputType.number,
      fillColor: selectedTextField == index ? AppColorData.appSecondaryColor : AppColorData.white02,
      controller: phoneInput,
      labelText: Strings.mobileNUmberLabel,
      contentPadding: const EdgeInsets.symmetric( horizontal: 14),
      /*validator: (value) =>
          validators.validateMobileNumber(value),*/
    );
  }

  Widget floatingActionWidget(){
    return FloatingActionButton(
      backgroundColor: AppColorData.appPrimaryColor,
        child: Icon(Icons.arrow_forward,color: AppColorData.appSecondaryColor,),
        onPressed: (){
          setState(() {
            errorMessage = validators.validateMobileNumber(phoneInput.text);
          });
          FocusManager.instance.primaryFocus?.unfocus();
          Logger.appLogs("Send OTP button clicked");
          /*if(phoneInput.text == "" && phoneInput.text.isEmpty){
            ToastContext().init(context);
            ToastUtil.showSnackBar(
                context,"Enter phone number");
          }*/
           if (phoneFormKey.currentState!.validate() && errorMessage == null) {
            Logger.appLogs(
                "object :: ${phoneFormKey.currentState?.validate()}");
            customToast(
                context: context,
                image: SVGAssets.success_toast,
                msg: "OTP send successfully");
            context.router.push(OtpRoute(isForgotPasswordPage: false,otpToken: 1234,type: "step_1"));
          } else {
            Logger.appLogs("object ot valid");
          }
        });
  }
}
