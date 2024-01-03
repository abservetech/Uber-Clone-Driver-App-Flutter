import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rebustar_driver/commonWidgets/common_widgets.dart';
import 'package:rebustar_driver/ui/ratings/ratings_list_bottom_screen.dart';

import '../../utils/utils.dart';

@RoutePage()
class RatingsPage extends StatefulWidget {
  const RatingsPage({super.key});

  @override
  State<RatingsPage> createState() => _RatingsPageState();
}

class _RatingsPageState extends State<RatingsPage> {
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
              title: Strings.ratingsMenu,
            ),
            centerTitle: false,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  color: AppColorData.transparent,
                  height: 14,
                ),
                profileAndNameWidget(),
                Container(
                  color: AppColorData.transparent,
                  height: 20,
                ),
                currentRatingWidget(),
                Container(
                  color: AppColorData.transparent,
                  height: 20,
                ),
                GestureDetector(
                  onTap: (){
                    print("object");
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      enableDrag: false,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20)
                          )),
                      backgroundColor: AppColorData.appSecondaryColor,
                      builder: (context) =>  RatingListSheet(),
                    );
                  },
                    child: riderFeedbackCardWidget()),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                )
              ]))

        ],
      ),
    );
  }

  Widget profileAndNameWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: Container(
          height: 60,width: 60,
          color: AppColorData.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CircleAvatar(
              radius: 28,
              foregroundColor: AppColorData.transparent,
              backgroundColor: AppColorData.transparent,
              child: Container(
                color: AppColorData.transparent,
                child: SvgPicture.asset(SVGAssets.emptyProfileImg),
              ),
            ),
          ),
        ),
        title: Text(
          "Emerson Levin",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: AppColorData.textColor,
              fontWeight: FontWeight.w700,
              fontSize: 30),
        ),
        subtitle: Text(
          "emerson.levin@gmail.com",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: AppColorData.grey03,
              fontWeight: FontWeight.w400,
              fontSize: 16),
        ),
      ),
    );
  }

  Widget currentRatingWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "4.15",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: AppColorData.textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: RatingBar.builder(
              ignoreGestures: true,
              initialRating: 4.15 ?? 0.0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 30,
              unratedColor: AppColorData.ratingColor.withOpacity(0.4),
              itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
              itemBuilder: (context, _) => Icon(
                Icons.star_rate_rounded,
                color: AppColorData.ratingColor,
              ),
              onRatingUpdate: (rating) {
                Logger.appLogs(rating);
              },
            ),
          ),
          SizedBox(height: 10,),
          Text(
              "Your Current Ratings",
              style: TextStyle(
                color: AppColorData.grey03,
                fontSize: 16,
                fontWeight:FontWeight.w400,
              )
          ),
          SizedBox(height: 14,),
          Container(
            decoration: BoxDecoration(
                color: AppColorData.appSecondaryColor,
                border: Border.all(
                    color: AppColorData.appPrimaryColor
                )
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                    child:
                    Container(
                        decoration: BoxDecoration(
                            color: AppColorData.appSecondaryColor,
                            border: Border(right: BorderSide(color: AppColorData.appPrimaryColor))
                        ),
                        child: countCard(count: 42,type: "Lifetime Trips",))),
                //Container(color: AppColorData.appPrimaryColor,width: 1,height: 80,),
                Expanded(
                    flex: 2,child: countCard(count: 33,type: "Rated Trips")),
                //Container(color: AppColorData.appPrimaryColor,width: 1,height: 80),
                Expanded(
                    flex: 2,
                    child:
                    Container(
                        decoration: BoxDecoration(
                            color: AppColorData.appSecondaryColor,
                            border: Border(left: BorderSide(color: AppColorData.appPrimaryColor))
                        ),
                        child: countCard(count: 42,type: "Fivestar Trips"))),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget riderFeedbackCardWidget(){
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
        color: AppColorData.appSecondaryColor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColorData.appPrimaryColor)
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 14.0),
            visualDensity: VisualDensity(horizontal: -1,vertical: -1),
            leading: Container(
              height: 60,width: 60,
              color: AppColorData.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CircleAvatar(
                  radius: 28,
                  foregroundColor: AppColorData.transparent,
                  backgroundColor: AppColorData.transparent,
                  child: Container(
                    color: AppColorData.transparent,
                    child: SvgPicture.asset(SVGAssets.feedback_icon),
                  ),
                ),
              ),
            ),
            title: Text(
              "Emerson Levin",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: AppColorData.textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            ),
            subtitle: Text(
              "checkout feedback from riders and learn how to improve",
              textAlign: TextAlign.left,
              style: TextStyle(
                height: 1.5,
                  color: AppColorData.grey03,
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
            trailing: Icon(Icons.arrow_forward_ios,color: AppColorData.appPrimaryColor),
          ),
        ),
      ),
    );
  }

Widget countCard({required int count, required String type}){
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                "$count",
                style: TextStyle(
                  color: AppColorData.appPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                )
            ),
            Text(
                type,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColorData.appPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )
            )
          ],
        ),
      ),
    );
}
}
