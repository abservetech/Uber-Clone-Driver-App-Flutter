import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart';
import 'package:rebustar_driver/routes/router_pages.gr.dart';
import '../../utils/utils.dart';
import '../commonWidgets/common_widgets.dart';


@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final List<String> errors = [];

  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  TextEditingController mailInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();
  AppValidators validators = AppValidators();
  bool isChecked = false;
  bool _passwordVisible = true;
  String? password;
  String? email;
  int? remember = 0;
  double? currentLatitude;
  double? currentLongitude;
  int selectedTextField = -1;
  Location location = Location();
  String? mailErrorMessage;
  String? passErrorMessage;


  @override
  void initState() {
    super.initState();
    selectedTextField = -1;
    getCurrentLocation();
  }

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        isLeadingWidget: true,
        backgroundColor: AppColorData.appSecondaryColor,
        leading: const SizedBox.shrink(),
      ),
      body: renderBody(),
    );
  }

  Widget renderBody(){
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                welComeWidget(),
                spacer(),
                welcomeContent(),
                spacer(),
                textFromField(
                  onTap: (){
                    setState(() {
                      selectedTextField = 0;
                    });
                  },
                  controller: mailInput,
                  keyboardType: TextInputType.emailAddress,
                  labelText: Strings.emailLabel,
                  prefixIcon: SVGAssets.envelope,
                    errorText: mailErrorMessage,
                  isSelected: (selectedTextField == 0)?true:false
                ),
                textFromField(
                    onTap: (){
                      setState(() {
                        selectedTextField = 1;
                      });
                    },
                    controller: passwordInput,
                    keyboardType: TextInputType.text,
                    labelText: Strings.passLabel,
                    prefixIcon:  SVGAssets.lock,
                    obscureText: _passwordVisible,
                    passwordVisibleSuffixIcon: true,
                  errorText: passErrorMessage,
                    isSelected: (selectedTextField == 1)?true:false,
                ),
                spacer(),
                rememberForgot(),
                spacer(),
                Text(
                  Strings.r,
                  style: TextStyle(
                    color: AppColorData.appPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                spacer(),
                GestureDetector(
                  child: Text(
                    Strings.signUpText,
                    style:
                    TextStyle(fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                        color: AppColorData.textColor,
                        fontSize: 16),
                  ),
                  onTap: (){
                    context.router.push(const MobileNumberRegisterRoute());
                  },
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CommonElevatedButton(
                    height: 60,
                    elevatedButtonName: Strings.loginText,
                    onTap: () async {
                      print("AppConstant.isPermissionGranted :11: ${AppConstant.isPermissionGranted}");
                      setState(() {
                        mailErrorMessage = validators.validateEmail(mailInput.text);
                        passErrorMessage = validators.validatePasswords(password1: passwordInput.text,password2: passwordInput.text);
                      });
                      AppConstant.isPermissionGranted = await checkPermission();
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (_formKey1.currentState!.validate()) {
                        _formKey1.currentState!.save();
                        if (currentLatitude != null && currentLongitude != null &&
                        mailErrorMessage == null && passErrorMessage == null) {
                          context.router.push(HomeRoute(
                            currentLat: currentLatitude,
                            currentLong: currentLongitude
                          ));
                        }
                      } else {
                        print("object else");
                      }
                    },
                  ),
                ),
                spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget welComeWidget(){
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        Strings.loginWelcome,
        style: TextStyle(
            color: AppColorData.textColor,
            fontWeight: FontWeight.w600,
            fontSize: 30),
      ),
    );
  }

  Widget welcomeContent(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          Strings.loginContent,
          style: TextStyle(
              height: 1.4,
              color: AppColorData.grey03,
              fontWeight: FontWeight.w400,
              fontSize: 16),
        ),
      ),
    );
  }

  Widget rememberForgot(){
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Transform.scale(
          scale:  (MediaQuery.of(context).size.width > 600)? 1.4 : 1,
          child: Checkbox(
            activeColor: AppColorData.appPrimaryColor,
            checkColor: AppColorData.appSecondaryColor,
            hoverColor: AppColorData.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            focusColor: AppColorData.appPrimaryColor,
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
                if(value == true){
                  remember = 1;
                }else{
                  remember = 0;
                }
              });
            },
          ),
        ),
        const Text(
          Strings.rememberText,
          style:
          TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
        ),
        const Spacer(),
        GestureDetector(
          child: Text(
            Strings.forgotPassText,
            style:
            TextStyle(fontWeight: FontWeight.w400,
                color: AppColorData.blue,
                fontSize: 16),
          ),
          onTap: (){
            context.router.push(GmailRegisterRoute(isForgotPasswordProcess: true));
          },
        ),
      ],
    );
  }
  
  Widget textFromField({Function()?  onTap,
    bool? isSelected = false,
    bool? obscureText = false,
    TextInputType? keyboardType,
    TextEditingController? controller,
    String? labelText,
    String? prefixIcon,
    String? errorText,
    bool? passwordVisibleSuffixIcon = false}){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: CommonTextFromField(
            onTap: onTap,
            border: Border.all(color: (errorText == null) ?(isSelected == true)? AppColorData.appPrimaryColor:AppColorData.transparent : AppColorData.errorColor,),
            keyboardType: keyboardType,
            obscureText: obscureText,
            controller:controller,
            fillColor: (isSelected == true) ? AppColorData.appSecondaryColor : AppColorData.white02,
            labelText: labelText,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            prefixIcon: Container(
              height: 20,width: 20,
                color: AppColorData.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: SvgPicture.asset(prefixIcon ?? ""),
                )),
            suffixIcon:(passwordVisibleSuffixIcon == true)? GestureDetector(
                onTap: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
                child: Icon(_passwordVisible
                    ? Icons.remove_red_eye_outlined
                    : CupertinoIcons.eye_slash ,
                  color: AppColorData.appPrimaryColor,
                  size: 22,
                )): SizedBox.shrink(),

          ),
        ),
        (errorText != null)?
        Row(
          children: [
            SvgPicture.asset(SVGAssets.error_icon),
            SizedBox(width: 10,),
            Text(errorText??'',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColorData.errorColor
              ),),
          ],
        ):SizedBox.shrink()
      ],
    );
  }

  Widget spacer(){
    return const SizedBox(
        height: 15
    );
  }

  void getCurrentLocation() async {
    print("AppConstant.isPermissionGranted :11: ${AppConstant.isPermissionGranted}");
    /*Future.delayed(Duration.zero, (){
      locationBottomSheet(context:context,validFun: (){});
    });*/
    setState(() {
      location.getLocation().then(
            (location) {
              print("object permission :: ${location.longitude} ${location.latitude}");
              currentLatitude = location.latitude;
              currentLongitude = location.longitude;
        },
      );
    });
  }


}
