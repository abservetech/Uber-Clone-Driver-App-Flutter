import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/utils.dart';

class CustomDropDownContainerWidget extends StatefulWidget {
  const CustomDropDownContainerWidget({super.key, this.title, required this.dropBox});
  final String? title;
final List<DropBox> dropBox;


  @override
  State<CustomDropDownContainerWidget> createState() => _CustomDropDownContainerWidgetState();
}

class _CustomDropDownContainerWidgetState extends State<CustomDropDownContainerWidget> {
  bool isExpanded = true;
  int? lastIndex;
  List<DropBox> dropBox =[
    /*DropBox(
      contentTitle: "Driving Licence",
    isUploadAvailable: true,
    uploadOnTap: (){},),
    DropBox(
      contentTitle: "Address Proof",
      uploadOnTap: (){},),
    DropBox(
      contentTitle: "RC Book",
      isUploadFailed: true,
      uploadErrorText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
      uploadOnTap: (){},),
    DropBox(
      contentTitle: "Driving Licence",
      isUploadWaiting: true,
      uploadErrorText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Turpis vitae ultrices in sed. Feugiat metus amet, id sed volutpat enim sed. Cras vel vitae, lectus id. Egestas quam auctor commodo porttitor netus risus enim. Nec mi neque malesuada aenean euismod est lorem.",
      uploadOnTap: (){},),*/
  ];
  @override
  void initState() {
    super.initState();
    dropBox = widget.dropBox;
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              height: 60,
              decoration: BoxDecoration(
                  color: AppColorData.appSecondaryColor,
                  border: Border.all(color: AppColorData.grey05),
              borderRadius: BorderRadius.vertical(top: Radius.circular(10),bottom:  Radius.circular((isExpanded == false)? 10:0))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.title ?? '',
                        style: TextStyle(
                          color: AppColorData.appPrimaryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        )),
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 30,
                      color: AppColorData.appPrimaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          LimitedBox(
            maxHeight: 2000,
            maxWidth: double.infinity,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                itemCount: dropBox.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: isExpanded ? 60 : 0,
                      maxHeight:  isExpanded ? double.infinity : 0,
                      maxWidth: double.infinity,
                    ),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 100*index),
                      // height:  isExpanded ? 200 : 0,
                      // width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColorData.appSecondaryColor,
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular((dropBox[index].isLastContainer == true)?10:0)),
                          border: Border(
                            right: BorderSide(color: AppColorData.grey05),
                            left: BorderSide(color: AppColorData.grey05),
                            bottom: BorderSide(color: AppColorData.grey05),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if(dropBox[index].uploadErrorText != "" && dropBox[index].isUploadFailed == true)
                              SizedBox(height: 10,),
                            Row(
                              children: [
                                Container(
                                  color: AppColorData.appSecondaryColor,
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  child: Text(
                                      dropBox[index].contentTitle ?? '',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColorData.appPrimaryColor,
                                        fontWeight: FontWeight.w400,
                                      )
                                  ),
                                ),
                                SizedBox(width: 10,),
                                GestureDetector(
                                  onTap: dropBox[index].uploadOnTap,
                                  child:  (dropBox[index].isUploadAvailable == true || dropBox[index].isUploadFailed == true)
                                      ?Text(
                                      Strings.upload,
                                      style: TextStyle(
                                        fontSize: 14,
                                        decoration: TextDecoration.underline,
                                        color: AppColorData.appPrimaryColor,
                                        fontWeight: FontWeight.w700,
                                      )
                                  ) :SizedBox(width: MediaQuery.of(context).size.width * 0.15,),
                                ),
                                SizedBox(width: 10,),
                                if(dropBox[index].isUploadAvailable != true)
                                  SvgPicture.asset(
                                      (dropBox[index].isUploadWaiting == true)
                                          ?SVGAssets.doc_waiting_icon
                                          :(dropBox[index].uploadErrorText != "" && dropBox[index].isUploadFailed == true)
                                          ? SVGAssets.doc_error_icon
                                          :SVGAssets.doc_save_icon),
                              ],
                            ),
                            if(dropBox[index].uploadErrorText != "" && dropBox[index].isUploadFailed == true)
                              Stack(
                                children: [
                                  Container(
                                    color: AppColorData.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 100*index),
                                        decoration: BoxDecoration(
                                            color: AppColorData.appPrimaryColor,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              dropBox[index].uploadErrorText ?? '',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: AppColorData.appSecondaryColor,
                                                fontWeight: FontWeight.w400,
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      right: 10.0 ,
                                      top: 2.0,
                                      child: Container(
                                        child: SvgPicture.asset(SVGAssets.container_arrow),
                                      )),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class DropBox{
  const DropBox(
      {
        this.contentTitle,
        this.uploadOnTap,
      this.uploadErrorText = '',
        this.isUploadAvailable = false,
        this.isUploadFailed = false,
        this.isLastContainer = false,
        this.isUploadWaiting = false});
  final String? contentTitle;
final Function()? uploadOnTap;
final String? uploadErrorText;
final bool? isUploadWaiting;
final bool? isUploadAvailable;
final bool? isUploadFailed;
final bool? isLastContainer;
}