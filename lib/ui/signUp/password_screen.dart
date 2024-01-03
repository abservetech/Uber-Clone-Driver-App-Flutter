import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart';
import 'package:rebustar_driver/routes/router_pages.gr.dart';
import '../../commonWidgets/common_widgets.dart';
import '../../utils/utils.dart';

@RoutePage()
class PasswordPage extends StatefulWidget {
  final bool? isSettingsNavigation;
  final bool? isResetPassword;
  final int? id;
  const PasswordPage(
      {super.key,
      this.isSettingsNavigation = false,
      this.id,
      this.isResetPassword});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  TextEditingController oldPasswordInput = TextEditingController();
  TextEditingController newPasswordInput = TextEditingController();
  TextEditingController confirmPasswordInput = TextEditingController();
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  AppValidators validators = AppValidators();
  String? token;
  String? email;
  LocationData? currentLocation;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _oldPasswordVisible = false;
  bool isNavigate = false;
  Location location = Location();
  int selectedTextField = -1;
  String? oldPassErrorMessage;
  String? newPassErrorMessage;
  String? confirmPassErrorMessage;

  @override
  void initState() {
    selectedTextField = -1;
    _passwordVisible = true;
    _confirmPasswordVisible = true;
    _oldPasswordVisible = true;
    super.initState();
    getCurrentLocation();
    if (widget.isResetPassword == true) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(
          isLeadingWidget: true,
          backgroundColor: AppColorData.transparent,/*(widget.isSettingsNavigation == true)
              ? AppColorData.appPrimaryColor
              : AppColorData.transparent,*/
          titleText: "", /*(widget.isSettingsNavigation == true)
              ? Strings.passAppBarTitle
              : '',*/
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: AppColorData.appPrimaryColor,/*(widget.isSettingsNavigation == true)
                    ? AppColorData.appSecondaryColor
                    : AppColorData.black,*/
                weight: 23),
            onPressed: () {
             // (widget.isSettingsNavigation == true)
                  //?
              context.router.pop();
                  //: context.router.popAndPush(GmailRegisterRoute());
            },
          ),
        ),
        body: renderBody());
  }

  Widget renderBody() {
    return Form(
      key: passwordFormKey,
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: AppColorData.transparent,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          // mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            textWidget(
                    isSubText: false,
                    text: (widget.isResetPassword == true)
                        ? Strings.resetPassTitle
                        : Strings.passTitle,
                  ),
            const SizedBox(height: 20),
            textWidget(
              isSubText: true,
              text: Strings.passSubText,
            ),
            (widget.isResetPassword == true)?const SizedBox(height: 20):const SizedBox.shrink(),
            (widget.isResetPassword == true)
                ? textFromField(
                errorText: oldPassErrorMessage,
                controller: oldPasswordInput,
                labelText: Strings.oldPassLabel,
                isSelected: (selectedTextField == 2) ? true: false,
                obscureText: _oldPasswordVisible,
                onTap: (){
                  setState(() {
                    selectedTextField = 2;
                  });
                },
                suffixIcon:  GestureDetector(
                    onTap: () {
                      setState(() {
                        _oldPasswordVisible = !_oldPasswordVisible;
                      });
                    },
                    child: Icon(_oldPasswordVisible
                        ? Icons.remove_red_eye_outlined
                        : CupertinoIcons.eye_slash,color: AppColorData.appPrimaryColor,))
            )
                :const SizedBox.shrink(),
            const SizedBox(height: 20),
            textFromField(
              errorText: newPassErrorMessage,
              controller: newPasswordInput,
              labelText: Strings.newPassLabel,
              isSelected: (selectedTextField == 0) ? true: false,
              obscureText: _passwordVisible,
                onTap: (){
                  setState(() {
                    selectedTextField = 0;
                  });
                },
              suffixIcon:  GestureDetector(
                  onTap: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  child: Icon(_passwordVisible
                      ? Icons.remove_red_eye_outlined
                      : CupertinoIcons.eye_slash,color: AppColorData.appPrimaryColor,))
            ),

            const SizedBox(height: 20),
            textFromField(
                errorText: confirmPassErrorMessage,
                controller: confirmPasswordInput,
                labelText: Strings.confirmPassLabel,
                isSelected: (selectedTextField == 1) ? true: false,
                obscureText: _confirmPasswordVisible,
                onTap: (){
                  setState(() {
                    selectedTextField = 1;
                  });
                },
                suffixIcon:  GestureDetector(
                    onTap: () {
                      setState(() {
                        _confirmPasswordVisible = !_confirmPasswordVisible;
                      });
                    },
                    child: Icon(_confirmPasswordVisible
                        ? Icons.remove_red_eye_outlined
                        : CupertinoIcons.eye_slash,color: AppColorData.appPrimaryColor,))

            ),
             Container(
               color: AppColorData.transparent,
                 height:
             (widget.isResetPassword == true)?
             MediaQuery.of(context).size.height *0.18
             : MediaQuery.of(context).size.height *0.34),
            submitWidget(),
            Container(height: 10,color: AppColorData.transparent),
          ],
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

  Widget textFromField({Function()?  onTap,
    bool? isSelected = false,
    bool? obscureText = false,
    TextEditingController? controller,
    String? labelText,
    String? errorText,
    Widget? suffixIcon}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        children: [
          CommonTextFromField(
            onTap: onTap,
            border: Border.all(color: (errorText == null) ?(isSelected == true)? AppColorData.appPrimaryColor:AppColorData.transparent : AppColorData.errorColor,),
            keyboardType: TextInputType.text,
            obscureText: obscureText,
            controller:controller,
            fillColor: (isSelected == true) ? AppColorData.appSecondaryColor : AppColorData.white02,
            labelText: labelText,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14),
            suffixIcon: suffixIcon,
          ),
          const SizedBox(height: 4,),
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
      ),
    );
  }

  Widget submitWidget(){
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child:  CommonElevatedButton(
          width: double.infinity,
            elevatedButtonName:(widget.isSettingsNavigation == true)? Strings.resetPassButton : Strings.confirmPassLabel,
            onTap: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              setState(() {
                selectedTextField = -1 ;
                newPassErrorMessage = validators.validatePasswords(password1: newPasswordInput.text,password2: confirmPasswordInput.text);
                confirmPassErrorMessage = validators.validatePasswords(password1: confirmPasswordInput.text,password2: newPasswordInput.text);
                oldPassErrorMessage = validators.validatePassword(oldPassword: oldPasswordInput.text);
              });
              if (passwordFormKey.currentState!.validate() && isNavigate == true) {
                getCurrentLocation();
                Logger.appLogs("Reset Password button clicked");
                Logger.appLogs("Passwordtxtxt${newPasswordInput.text} ");
                if( newPassErrorMessage == null && confirmPassErrorMessage == null && oldPassErrorMessage == null){
                  Logger.appLogs("Reset Password button clicked");
                }
                if (widget.isSettingsNavigation == true) {
                  context.router.pop();
                } else {
                  Map<String, dynamic> resetPassParam;
                  resetPassParam = {
                    "page": "step3",
                    "password": newPasswordInput.text,
                    "password_confirmation":
                    confirmPasswordInput.text,
                    "id": widget.id
                  };
                  context.router.push( HomeRoute(
                      currentLong: currentLocation?.longitude,
                      currentLat: currentLocation?.latitude
                  ));
                }
              }
            }));
  }

  void getCurrentLocation() async {
    isNavigate = await requestPermission();
    setState(() {
      location.getLocation().then(
            (location) {
          print("object permission :: ${location.latitude}");
          currentLocation = location;
        },
      );
    });
  }
}
