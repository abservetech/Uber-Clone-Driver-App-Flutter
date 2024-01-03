import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rebustar_driver/routes/router_pages.gr.dart';
import '../../commonWidgets/common_widgets.dart';
import '../../utils/utils.dart';

@RoutePage()
class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController eMail = TextEditingController();
  final TextEditingController phoneInput = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AppValidators validators = AppValidators();
  String? countryCode = 'IN';
  int selectedTextField = -1;
  XFile? selectFile;
  String? firstNameErrorMessage;
  String? lastNameErrorMessage;
  String? eMailErrorMessage;
  String? numberErrorMessage;

  @override
  void initState() {
    super.initState();
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
              title: Strings.profileMenu,
            ),
            centerTitle: false,
          ),
          SliverList(delegate: SliverChildListDelegate(
            [
              Container(
            color: AppColorData.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    profileImageWidget(),
                    const SizedBox(
                      height: 20,
                    ),
                    textFromField(
                        onTap: (){
                        setState(() {
                          selectedTextField = 0;
                        });
                      },
                      keyboardType: TextInputType.text,
                      isSelected: (selectedTextField == 0)? true:false,
                      labelText: Strings.firstNameLabel,
                      controller: firstName,
                      errorText: firstNameErrorMessage
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    textFromField(
                        onTap: (){
                          setState(() {
                            selectedTextField = 1;
                          });
                        },
                        keyboardType: TextInputType.text,
                        isSelected: (selectedTextField == 1)? true:false,
                        labelText: Strings.lastNameLabel,
                        controller: lastName,
                        errorText: lastNameErrorMessage
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    textFromField(
                        onTap: (){
                          setState(() {
                            selectedTextField = 2;
                          });
                        },
                        keyboardType: TextInputType.emailAddress,
                        isSelected: (selectedTextField == 2)? true:false,
                        labelText: Strings.email,
                        controller: eMail,
                        errorText: eMailErrorMessage
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    phoneNumberWithCountryTextField(errorText: numberErrorMessage),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: changePasswordButton()),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CommonElevatedButton(
                        height: 60,
                        elevatedButtonName: Strings.updateText,
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Logger.appLogs("object else");
                          setState(() {
                            selectedTextField = -1;
                            firstNameErrorMessage =validators.validateName(firstName.text, false);
                            lastNameErrorMessage =validators.validateName(lastName.text, true);
                            eMailErrorMessage = validators.validateEmail(eMail.text);
                            numberErrorMessage = validators.validateMobileNumber(phoneInput.text);
                          });
                          if(firstNameErrorMessage == null && lastNameErrorMessage == null && eMailErrorMessage == null && numberErrorMessage == null){
                            Logger.appLogs("there is no error");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
            ]
          ))
        ],
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

  phoneNumberWithCountryTextField({String? errorText}) {
    return Column(
      children: [
        Row(
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
              child: textFromField(
                  onTap: (){
                    setState(() {
                      selectedTextField = 3;
                    });
                  },
                  border: Border.all(color: (errorText == null) ?(selectedTextField == 3)? AppColorData.appPrimaryColor:AppColorData.transparent : AppColorData.errorColor,),
                  keyboardType: TextInputType.number,
                  isSelected: (selectedTextField == 3)? true:false,
                  labelText: Strings.mobileNUmberLabel,
                  controller: phoneInput,
                  errorText: null
              ),
            ),
          ],
        ),
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
    );
  }

  Widget profileImageWidget() {
    return Center(
      child: GestureDetector(
        onTap: (){
          showModalBottomSheet(context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20)
              )
            ),
            enableDrag: false,
            isDismissible: false,
            builder: (context) => profileBottomSheet(
              imageCallBack: (ImageSource source,) async {
                await getImage(source);
              },
            ),);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                color: AppColorData.transparent,
                borderRadius: BorderRadius.circular(100)),
            child: (selectFile != null) ?
            Image.file(File(selectFile!.path),fit: BoxFit.fill) :
            SvgPicture.asset(
                SVGAssets.emptyProfileImg
            ),
          ),
        ),
      ),
    );
  }

  Widget textFromField({
    Function()?  onTap,
    bool? isSelected = false,
    TextInputType? keyboardType,
    TextEditingController? controller,
    String? labelText,
    BoxBorder? border,
    String? errorText,}) {
    return Column(
      children: [
        CommonTextFromField(
          onTap: onTap,
          border: border ?? Border.all(color: (errorText == null) ?(isSelected == true)? AppColorData.appPrimaryColor:AppColorData.transparent : AppColorData.errorColor,),
          keyboardType: keyboardType,
          fillColor: (isSelected == true)
              ? AppColorData.appSecondaryColor
              : AppColorData.white02,
          controller: controller,
          labelText: labelText,
          contentPadding: const EdgeInsets.symmetric( horizontal: 14),
        ),
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
    );
  }


  Widget changePasswordButton() {
    return  GestureDetector(
      onTap: (){
        context.router.push(PasswordRoute(isResetPassword: true,isSettingsNavigation: true));
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            Strings.changePass,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
                color: AppColorData.appPrimaryColor),
          ),
          const SizedBox(width: 10,),
          Container(
            height: 30,width: 30,
            decoration: BoxDecoration(
              color: AppColorData.appPrimaryColor,
              borderRadius: BorderRadius.circular(100)
            ),
            child: Center(child: Icon(FontAwesomeIcons.arrowRight,
                color: AppColorData.appSecondaryColor,
            size: 20,)),
          )

        ],
      ),
    );
  }

  profileBottomSheet({required Function imageCallBack}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        color: AppColorData.appSecondaryColor
      ),
      child: Padding(
        padding: const EdgeInsets.only( bottom: 8.0),
        child: Wrap(
          children: <Widget>[
            Container(
              color: AppColorData.transparent,
              height: 8,
            ),
            Center(
              child: Container(
                color: AppColorData.appPrimaryColor.withOpacity(0.1),
                height: 5,
                width: 100,
              ),
            ),
            (selectFile != null)?Container(
              height: 20,
              color: AppColorData.transparent,) : const SizedBox.shrink(),
            (selectFile != null)?
            Center(
              child: Container(
                height: 150,
                width: 150,
                color: AppColorData.transparent,
                child: Image.file(File(selectFile!.path),fit: BoxFit.cover),
              ),
            ) : const SizedBox.shrink(),
            Container(
              height: 20,
              color: AppColorData.transparent,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              bottomSheetOption(
                  icon: Icons.photo_camera,
                  title: 'Camera',
                  index: 1,
                  imageCallBack: imageCallBack
              ),
              bottomSheetOption(
                  icon: Icons.image,
                  title:'Gallery',
                  index: 2,
                  imageCallBack: imageCallBack
              ),
                bottomSheetOption(
                    icon: Icons.cancel,
                    title:'Cancel',
                    index: 3,
                    imageCallBack: imageCallBack
                ),
            ],),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  Widget bottomSheetOption({required IconData icon, required String title, required int index,required Function imageCallBack}) {
    return GestureDetector(
      onTap: () async {
        if(index == 1) {
          try {
            await  imageCallBack(ImageSource.camera);
            context.router.pop();
          } catch (e1) { Logger.appLogs("e1 error :: $e1");}
        }
        else if(index == 2){
          try {
            await   imageCallBack(ImageSource.gallery);
            context.router.pop();
          } catch (e2) { Logger.appLogs("e2 error :: $e2");}
        }
        else{
          context.router.pop();
        }
      },
      child: Column(
        children: [
          Container(
            height: 50,width: 50,
            decoration:  BoxDecoration(
                color: AppColorData.transparent,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: AppColorData.dividerColor)
            ),
            child: Icon(
              icon,
              color: AppColorData.appPrimaryColor,
            ),
          ),
          const SizedBox(height: 10,),
          Text(
            title,
            style: TextStyle(
                color: AppColorData.appPrimaryColor,
                fontWeight: FontWeight.w400,
                fontSize: 14
            ),
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }

  Future getImage(
      ImageSource source) async {
    XFile? image = await ImagePicker().pickImage(source: source);
    cropImage(image);
  }

  cropImage(image) async {
    CroppedFile? croppedImg;
    if (image != null) {
      try {
        croppedImg  = await ImageCropper().cropImage(
            sourcePath: "${image.path}",
            compressQuality: 80,
            maxHeight: 1080,
            maxWidth: 1080,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.original,
            ],
            uiSettings: [
              AndroidUiSettings(
                  toolbarTitle: 'Set profile picture',
                  toolbarColor: AppColorData.appPrimaryColor,
                  toolbarWidgetColor: AppColorData.appSecondaryColor,
                  activeControlsWidgetColor: AppColorData.appPrimaryColor,
                  initAspectRatio: CropAspectRatioPreset.original,
                  lockAspectRatio: false),
              IOSUiSettings(
                title: 'Set profile picture',
                minimumAspectRatio: 1.0,
                aspectRatioLockEnabled: false,
              )]);
      } catch (e) {Logger.appLogs("in error the image crop ::$e");}
      final XFile file = XFile(croppedImg!.path);
      if (file != null) {
        selectFile = file;
        setState(() {});
      }
    }
  }
  
}
