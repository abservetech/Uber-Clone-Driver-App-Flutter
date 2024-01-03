import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rebustar_driver/routes/router_pages.gr.dart';

import '../../commonWidgets/common_widgets.dart';
import '../../utils/utils.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  @override
  Widget build(BuildContext context) {
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
            title: "Verifications",
          ),
          centerTitle: false,
        ),
        SliverList(delegate: SliverChildListDelegate([
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: CustomDropDownContainerWidget(
              dropBox: [
                DropBox(
                  contentTitle: "Driving Licence",
                  isUploadAvailable: true,
                  uploadOnTap: (){
                    context.router.push(DocUploadRoute( ));
                  },),
                DropBox(
                  contentTitle: "Address Proof",
                  isUploadAvailable: true,
                  uploadOnTap: (){
                    context.router.push(DocUploadRoute(showFrontDocOnly: true ));
                  },),
                DropBox(
                  contentTitle: "RC Book",
                  isUploadAvailable: true,
                  uploadErrorText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
                  uploadOnTap: (){
                    context.router.push(DocUploadRoute( showFrontDocOnly: true));
                  },)
              ],
              title: "Driver Documents",
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: CustomDropDownContainerWidget(
              dropBox: [
                DropBox(
                  contentTitle: "RC Book",
                  isUploadAvailable: true,
                  uploadOnTap: (){
                    context.router.push(DocUploadRoute( ));
                  },),
                DropBox(
                  contentTitle: "Insurance",
                  uploadOnTap: (){
                    context.router.push(DocUploadRoute( showFrontDocOnly: true));
                  },),
                DropBox(
                  contentTitle: "Fitness Certificate",
                  isUploadFailed: true,
                  isLastContainer: true,
                  uploadErrorText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
                  uploadOnTap: (){
                    context.router.push(DocUploadRoute( ));
                  },),
              ],
              title: "Vehicle Documents",
            ),
          )
        ]))
      ]),
    );
  }
}
