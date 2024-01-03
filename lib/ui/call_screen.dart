
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toast/toast.dart';

import '../commonWidgets/toastWidget/custom_snack_bar.dart';
import '../commonWidgets/toastWidget/toast_widget.dart';
import '../utils/utils.dart';

@RoutePage()
class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  bool isMuted = false;
  bool isSpeakerOn =false;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColorData.appSecondaryColor,
        image: const DecorationImage(image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/e/ef/M.s.dhoni.png"),fit: BoxFit.fill)
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              color: AppColorData.transparent,
              height: 160,
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, (MediaQuery.of(context).size.width*0.48).toDouble()),
                    painter: RPSCustomPainter(),
                  ),
                  Positioned(
                    right: 14,
                    top: 24,
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          isSpeakerOn = !isSpeakerOn;
                        });
                        print("isMuted = $isSpeakerOn");
                      },
                      child: Container(
                        color: AppColorData.transparent,
                        height: 50,width: 50,
                        child: Center(child: SvgPicture.asset((isSpeakerOn == true)?SVGAssets.speakerOnIcon:SVGAssets.speakerOffIcon)),
                      ),
                    )
                  ),
                  Positioned(
                      right: 120,
                      top: 14,
                      child: GestureDetector(
                        onTap: (){
                          print("call Ended");
                          ToastContext().init(context);
                          ToastUtil.showSnackBar(
                              context, "Call ended");
                          context.router.pop();
                        },
                        child: Container(
                          color: AppColorData.transparent,
                          height: 70,width: 70,
                          child: Center(child: SvgPicture.asset(SVGAssets.cutCallIcon)),
                        ),
                      )
                  ),
                  Positioned(
                      left: 14,
                      bottom: 24,
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            isMuted = !isMuted;
                          });
                         print("isMuted = $isMuted");
                        },
                        child: Container(
                          color: AppColorData.transparent,
                          height: 50,width: 50,
                          child: Center(child: SvgPicture.asset((isMuted == true)? SVGAssets.mutedIcon:SVGAssets.unMutedIcon)),
                        ),
                      )
                  ),
                  Positioned(
                    bottom: 14,
                    right: 14,
                    child: Container(
                      color: AppColorData.transparent,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          DefaultTextStyle(
                            style: TextStyle(
                                color: AppColorData.appSecondaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                            overflow: TextOverflow.ellipsis),
                            child: const Text('James Franci',maxLines: 1),
                          ),
                          const SizedBox(height: 8,),
                          DefaultTextStyle(
                            style: TextStyle(
                                color: AppColorData.appSecondaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                            child: const Text('02:30 min',),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(0,size.height*1.002353);
    path_0.lineTo(0,size.height*0.6543527);
    path_0.cubicTo(size.width*0.02550093,size.height*0.4468058,size.width*0.08660537,size.height*0.4302053,size.width*0.2377313,size.height*0.4904541);
    path_0.cubicTo(size.width*0.3379883,size.height*0.5132319,size.width*0.3782477,size.height*0.4716473,size.width*0.4133037,size.height*0.2726715);
    path_0.cubicTo(size.width*0.4740607,size.height*0.03153382,size.width*0.4974299,size.height*-0.04038560,size.width*0.6270444,size.height*0.02053406);
    path_0.cubicTo(size.width*0.6892033,size.height*0.06992802,size.width*0.7273715,size.height*0.1440198,size.width*0.8091612,size.height*0.1103425);
    path_0.cubicTo(size.width*0.9141822,size.height*0.04793097,size.width*0.9594650,size.height*0.07525169,size.width,size.height*0.2726715);
    path_0.lineTo(size.width,size.height*1.002353);
    path_0.lineTo(0,size.height*1.002353);
    path_0.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = AppColorData.appPrimaryColor.withOpacity(1.0);
    canvas.drawPath(path_0,paint_0_fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}