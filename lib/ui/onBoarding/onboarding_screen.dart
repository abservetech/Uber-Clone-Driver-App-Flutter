import 'package:auto_route/auto_route.dart';
import 'package:rebustar_driver/routes/router_pages.gr.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import '../../utils/utils.dart';

@RoutePage()
class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> with TickerProviderStateMixin{
 late TabController controller;
  /*final _controller = PageController(
    initialPage: 0,
  );*/
 AnimationController? _animationController;
  int _selectedIndex = 0;
 int tabLength = 3;
 bool? isNavigate =false;

 @override
 void initState() {
   // TODO: implement initState
   super.initState();
   controller = TabController(length: tabLength, vsync: this);
   controller.addListener(() {
     setState(() {
       _selectedIndex = controller.index;
     });
       print("Selected Index: ${controller.index}");
   });
   _animationController = AnimationController(
     vsync: this,
     duration: Duration(seconds: 4),
   );
   _animationController!.forward();
   _animationController!.addListener(() {
     setState(() {
       double progress = _animationController!.value;

       if(_selectedIndex >= 2){
         if(progress == 1.0) {
           context.router.push(LoginRoute());
           print("Selected Index 1: ${controller.index}");
         }
       }

       else{
         if(progress == 1.0){
       print("Selected Index 2: ${controller.index}");
           setState(() {
             controller.animateTo(_selectedIndex += 1, duration: const Duration(microseconds: 10), curve: Curves.bounceIn);
           });
           _animationController?.forward(from: 0.0);
         }}
     });
   });
 }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorData.appSecondaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: onBoardingBody(),
        )
    );
  }
Widget onBoardingBody(){
   return Column(
     children: [
       Expanded(
         child: Container(
           color: AppColorData.transparent,
           //height: MediaQuery.of(context).size.height * 0.7,
           width: double.infinity,
           child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
             controller: controller,
             children: [
               onBoardingWidget(
                   imgPath: PNGAssets.onBoarding1,
                   title: Strings.onBoardTitleText,
                   subTitle: Strings.onBoardSubText
               ),
               onBoardingWidget(
                   imgPath: PNGAssets.onBoarding2,
                   title: Strings.onBoardTitleText,
                   subTitle: Strings.onBoardSubText
               ),
               onBoardingWidget(
                   imgPath: PNGAssets.onBoarding3,
                   title: Strings.onBoardTitleText,
                   subTitle: Strings.onBoardSubText
               ),
             ],
           ),
         ),
       ),
       Container(
         width: double.infinity,
         // height: MediaQuery.of(context).size.height * 0.2,
         decoration: BoxDecoration(
             color: AppColorData.appSecondaryColor,
             borderRadius: const BorderRadius.only(
                 topLeft: Radius.circular(20),
                 topRight: Radius.circular(20)
             )
         ),
         child: Wrap(
           children: [
             Align(
               alignment: Alignment.center,
               child: Padding(
                   padding: const EdgeInsets.all(5.0),
                   child: DotsIndicator(
                     dotsCount: tabLength,
                     position: _selectedIndex.toInt(),
                     decorator: DotsDecorator(
                       color: AppColorData.grey03,
                       activeColor:AppColorData.appSecondaryColor,
                       activeSize: const Size(20.0, 14.0),
                       activeShape: CircleBorder(side: BorderSide(color: AppColorData.grey03,
                           width: 3.0),),
                     ),
                   )),
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 (_selectedIndex == 2)
                     ? SizedBox.shrink()
                     : GestureDetector(
                   onTap: (){
                     context.router.push(LoginRoute());
                   },
                   child: Text(
                       Strings.skip,
                       style: TextStyle(
                         color: AppColorData.grey,
                         decoration: TextDecoration.underline,
                         fontSize: 20,
                         fontWeight: FontWeight.w400,
                       )
                   ),
                 ),
                 Align(
                     alignment: Alignment.centerRight,
                     child: animatedButton()),
               ],
             ),
              Container(height: 20,
             color: AppColorData.transparent),
           ],
         ),
       )
     ],
   );
}

  Widget onBoardingWidget({String? title,String? subTitle,required String imgPath}) {
    return Container(
      color: AppColorData.appSecondaryColor,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //const SizedBox(height: 50),

          const SizedBox(height: 50),
          Text(title ?? '',
              maxLines: 2,
              textAlign: TextAlign.left,
              style: TextStyle(
                height: 0.9,
                  color: AppColorData.textColor,
                  fontSize: 30,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w700
              )),
          const SizedBox(height: 20),
          Text(subTitle ?? '',
              textAlign: TextAlign.left,
              style: TextStyle(
                height: 1.5,
                  color: AppColorData.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400
              )),
          const SizedBox(height: 10),
          Center(
            child: Image.asset(imgPath),
          ),
          Container(
            color: AppColorData.transparent,
            height: 10,
          ),
        ],
      ),
    );
  }

 void _startAnimation() {
   if(_selectedIndex >= 2){
     context.router.push(LoginRoute());
   }
   else{
     setState(() {
       controller.animateTo(_selectedIndex + 1, duration: const Duration(microseconds: 10), curve: Curves.bounceIn);
     });
     _animationController?.forward(from: 0.0);
   }
 }

 Widget animatedButton(){
   return Container(
      height: 60,
      width: 60,
      color: AppColorData.transparent,
      child: Stack(
        children: [
          Container(
            height: 60,
            width: 60,
            color: AppColorData.transparent,
            child: CircularProgressIndicator(
              strokeWidth: 5,
              value: _animationController!.value, // Set the progress value
              valueColor: AlwaysStoppedAnimation<Color>(AppColorData.grey),
              backgroundColor: AppColorData.grey03,
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: (){
                _startAnimation();
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: AppColorData.grey03,
                    borderRadius: BorderRadius.circular(100)
                ),
                child: Center(
                  child: Icon(Icons.arrow_forward_ios,size: 16,color: AppColorData.appSecondaryColor),
                )
              ),
            ),
          )
        ],
      ),
    );
  }

}
