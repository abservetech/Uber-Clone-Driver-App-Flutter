import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../commonWidgets/common_widgets.dart';
import '../../utils/utils.dart';

@RoutePage()
class DocUploadPage extends StatefulWidget {
  const DocUploadPage({
    super.key,
    this.isDriverPage = false,
    this.showFrontDocOnly = false,
  });

  final bool? isDriverPage;
  final bool? showFrontDocOnly;

  @override
  State<DocUploadPage> createState() => _DocUploadPageState();
}

class _DocUploadPageState extends State<DocUploadPage> {
  List<XFile>? imageFiles = [];
  List<String> list = ["Upload front image", "Upload Back image"];
  DateTime? selectedDate;
  String? expDate;
  XFile? selectFile;

  @override
  Widget build(BuildContext context) {
    print("imageFiles :: ${imageFiles!.length} :: ${imageFiles}");
    return Scaffold(
      backgroundColor: AppColorData.appSecondaryColor,
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          foregroundColor: AppColorData.appSecondaryColor,
          elevation: 0.9,
          pinned: true,
          floating: true,
          expandedHeight: 100,
          backgroundColor: AppColorData.appSecondaryColor,
          flexibleSpace: CommonSliverAppBar(
            title: (widget.isDriverPage == true)
                ? Strings.addDriverDocTitle
                : Strings.addVehicleDocTitle,
          ),
          centerTitle: false,
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Text(
              "Upload your Document details",
              style: TextStyle(
                fontSize: 16,
                color: AppColorData.grey03,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          uploadCardWidget(
              title: "Upload front image",
              imgPath: (imageFiles!.isEmpty) ? "" : imageFiles![0].path,
              selectIndex: 0),
          (widget.showFrontDocOnly == true)
              ? const SizedBox.shrink()
              : uploadCardWidget(
                  title: "Upload Back image",
                  imgPath: (imageFiles!.isEmpty || imageFiles!.length == 1)
                      ? ""
                      : imageFiles![1].path,
                  selectIndex: 1),
          spacer(),
          getExpiryDateWidget(),
          spacer(),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
            child: CommonElevatedButton(
              height: 60,
              elevatedButtonName: Strings.upload,
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                print("object else :: ");
                if (imageFiles!.isEmpty || imageFiles == []) {
                  customToast(
                      context: context,
                      image: SVGAssets.error_toast,
                      msg: "Please Upload your document");
                } else if (expDate == null || expDate == "") {
                  customToast(
                      context: context,
                      image: SVGAssets.error_toast,
                      msg: "Please select expiry date");
                }
                else{
                  context.router.pop();
                  customToast(
                      context: context,
                      image: SVGAssets.success_toast,
                      msg: "Document uploaded");
                }
              },
            ),
          ),
        ]))
      ]),
    );
  }

  Widget spacer() {
    return const SizedBox(
      height: 15,
    );
  }

  Widget uploadCardWidget(
      {required String title,
      String? imgPath,
      Function()? onTap,
      required int selectIndex}) {
    print("imageFiles :: ${imageFiles!.length} :: ${imageFiles}");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spacer(),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: AppColorData.appPrimaryColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(15),
            dashPattern: [5, 5],
            color: AppColorData.dottedBorderColor,
            strokeWidth: 1,
            child: GestureDetector(
              onTap: () {
                print("object");
                showModalBottomSheet(
                  context: context,
                  backgroundColor: AppColorData.appSecondaryColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20))),
                  enableDrag: false,
                  isDismissible: false,
                  builder: (context) => profileBottomSheet(
                    selectedImage:
                        (imageFiles!.isEmpty || imageFiles!.length == 1)
                            ? ""
                            : imageFiles![selectIndex].path,
                    selectedImgIndex: selectIndex,
                    imageCallBack: (
                      ImageSource source,
                    ) async {
                      await getImage(source, selectIndex);
                    },
                  ),
                );
              },
              child: Container(
                height: (imgPath != null && imgPath != "") ? 200 : 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColorData.appPrimaryColor.withOpacity(0.05)),
                child: (imgPath != null && imgPath != "")
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                      child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColorData.transparent),
                      child: Image.file(File(imgPath), fit: BoxFit.cover)),
                    )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(SVGAssets.file_upload_icon),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              Strings.uploadImg,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColorData.appPrimaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ), /* Spacer(),
                      SvgPicture.asset(SVGAssets.delete_icon),*/
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getExpiryDateWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: GestureDetector(
        onTap: () {
          selectDate(context, expDate);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Expiry date",
              style: TextStyle(
                fontSize: 16,
                color: AppColorData.appPrimaryColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColorData.appPrimaryColor.withOpacity(0.05)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(SVGAssets.calendar_icon),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      expDate ?? "Enter your Expiry Date",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColorData.appPrimaryColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context, String? selectDate) async {
    final now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime(now.year, now.month, now.day + 1),
      //selectedDate ?? DateTime.now(),
      firstDate: DateTime(now.year, now.month, now.day + 1),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              surface: AppColorData.appSecondaryColor,
              // calender heading background
              onSurface: AppColorData.appPrimaryColor,
              // AppColorData.appBarTextColor, // heading and date color
              onPrimary: AppColorData.appSecondaryColor,
              // selected date color
              primary: AppColorData
                  .appPrimaryColor, // selected date background color
            ),
            dialogBackgroundColor: AppColorData.appSecondaryColor,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    AppColorData.appPrimaryColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        expDate = "${picked.day}-${picked.month}-${picked.year}";
        print("selectDate :: $selectDate");
      });
    }
  }

  profileBottomSheet(
      {required Function imageCallBack,
      required String selectedImage,
      required int selectedImgIndex}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          color: AppColorData.appSecondaryColor),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
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
            (selectFile != null)
                ? Container(
                    height: 20,
                    color: AppColorData.transparent,
                  )
                : const SizedBox.shrink(),
            (selectedImage != "")
                ? Center(
                    child: Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        color: AppColorData.transparent,
                        child:
                            Image.file(File(selectedImage), fit: BoxFit.cover),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            Container(
              height: 20,
              color: AppColorData.transparent,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                bottomSheetOption(
                    icon: Icons.photo_camera,
                    title: 'Camera',
                    index: 1,
                    imageCallBack: imageCallBack),
                bottomSheetOption(
                    icon: Icons.image,
                    title: 'Gallery',
                    index: 2,
                    imageCallBack: imageCallBack),
                bottomSheetOption(
                    icon: Icons.delete,
                    title: 'Delete',
                    index: 3,
                    imgIndex: selectedImgIndex,
                    imageCallBack: imageCallBack),
                bottomSheetOption(
                    icon: Icons.cancel,
                    title: 'Cancel',
                    index: 4,
                    imageCallBack: imageCallBack),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomSheetOption(
      {required IconData icon,
      required String title,
      required int index,
      required Function imageCallBack,
      int? imgIndex}) {
    return GestureDetector(
      onTap: () async {
        if (index == 1) {
          try {
            await imageCallBack(ImageSource.camera);
            context.router.pop();
          } catch (e1) {
            Logger.appLogs("e1 error :: $e1");
          }
        } else if (index == 2) {
          try {
            await imageCallBack(ImageSource.gallery);
            context.router.pop();
          } catch (e2) {
            Logger.appLogs("e2 error :: $e2");
          }
        } else if (index == 3) {
          setState(() {
            imageFiles!.removeAt(imgIndex!);
          });
          context.router.pop();
        } else {
          context.router.pop();
        }
      },
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: AppColorData.transparent,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: AppColorData.dividerColor)),
            child: Icon(
              icon,
              color: AppColorData.appPrimaryColor,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(
                color: AppColorData.appPrimaryColor,
                fontWeight: FontWeight.w400,
                fontSize: 14),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Future<void> getImage(ImageSource source, int selectedIndex) async {
    XFile? image = await ImagePicker().pickImage(source: source);
    cropImage(image, selectedIndex);
  }

  cropImage(image, int selectedIndex) async {
    CroppedFile? croppedImg;
    if (image != null) {
      try {
        croppedImg = await ImageCropper().cropImage(
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
                  toolbarTitle: '',
                  toolbarColor: AppColorData.appPrimaryColor,
                  toolbarWidgetColor: AppColorData.appSecondaryColor,
                  activeControlsWidgetColor: AppColorData.appPrimaryColor,
                  initAspectRatio: CropAspectRatioPreset.original,
                  lockAspectRatio: false),
              IOSUiSettings(
                title: 'Set profile picture',
                minimumAspectRatio: 1.0,
                aspectRatioLockEnabled: false,
              )
            ]);
      } catch (e) {
        Logger.appLogs("in error the image crop ::$e");
      }
      final XFile file = XFile(croppedImg!.path);
      if (file != null) {
        selectFile = file;
        imageFiles?.insert(selectedIndex, selectFile!);
        setState(() {});
      }
    }
  }
}
