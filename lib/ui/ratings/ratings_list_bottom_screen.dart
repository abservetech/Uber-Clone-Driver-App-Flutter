
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/utils.dart';

class RatingListSheet extends StatefulWidget {
  const RatingListSheet({super.key});

  @override
  State<RatingListSheet> createState() => _RatingListSheetState();
}

class _RatingListSheetState extends State<RatingListSheet> {
  @override
  Widget build(BuildContext context) {
    return ratingListSheet();
  }

  Widget ratingListSheet() {
    return DraggableScrollableSheet(
        initialChildSize: 0.5,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
              color: AppColorData.appSecondaryColor,
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              //controller: scrollController,
              children: [
                Container(color: AppColorData.transparent,height: 4,),
                Center(
                  child: Container(
                    width: 100,
                    color: AppColorData.appPrimaryColor.withOpacity(0.15),
                    height: 3,),),
                Container(
                  height: 10,
                  width: 10,
                  color: Colors.transparent,
                ),
                Container(
                  color: AppColorData.transparent,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.router.pop();
                        },
                        child: Container(
                          height: 32,
                          width: 32,
                          color: Colors.transparent,
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                      const SizedBox(width: 14,),
                       Text(
                          "Rider Feedback",
                          style: TextStyle(
                            color: AppColorData.appPrimaryColor,
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          )
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                    return  ratingDetailsCard(
                      name: "Lincoln Rhiel Madsen",
                      comments: "Dr. Jenny is very professional in her work and responsive. I have consulted and my problem is solved",
                      rating: "4.5",
                      commentUpdateDate: "15 days ago",
                      likeCount: "854",
                    );
                  },),
                ),
                Container(
                  height: 10,
                  width: 10,
                  color: Colors.transparent,
                ),
              ],
            ),
          ),
        ));
  }

 Widget ratingDetailsCard({
   String? name,
   String? rating,
   String? comments,
   String? likeCount,
   String? profileImage,
   String? commentUpdateDate}) {
    return Container(
     // height: 160,
      decoration: BoxDecoration(
        color: AppColorData.appSecondaryColor,
        border: Border(
          bottom: BorderSide(color: AppColorData.white02)
        )
      ),
      child: Column(
        children: [
          const SizedBox(height: 14,),
          Row(
           // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Container(
              height: 50,width: 50,
              color: AppColorData.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CircleAvatar(
                  radius: 28,
                  foregroundColor: AppColorData.transparent,
                  backgroundColor: AppColorData.transparent,
                  child: Container(
                    color: AppColorData.transparent,
                    child: SvgPicture.asset(profileImage ?? SVGAssets.emptyProfileImg),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10,),
            Container(
              color: AppColorData.transparent,
              width: MediaQuery.of(context).size.width * 0.46,
              child: Text(
                  name ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  )
              ),
            ),
            SizedBox(width: 10,),
            Container(
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                  color: AppColorData.appSecondaryColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColorData.appPrimaryColor)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBar.builder(
                    ignoreGestures: true,
                    initialRating: 1 ,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 1,
                    itemSize: 22,
                    unratedColor: AppColorData.ratingColor.withOpacity(0.4),
                    itemPadding: const EdgeInsets.only(bottom: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star_rate_rounded,
                      color: AppColorData.ratingColor,
                    ),
                    onRatingUpdate: (rating) {
                      Logger.appLogs(rating);
                    },
                  ),
                  SizedBox(width: 5,),
                  Text(
                      rating ?? "",
                      style: TextStyle(
                        color: AppColorData.appPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )
                  ),
                  SizedBox(width: 5,)
                ],
              ),
            ),
            SizedBox(width: 10,),
            Container(
              height: 24,width: 24,
              decoration: BoxDecoration(
                color: AppColorData.appSecondaryColor,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: AppColorData.appPrimaryColor),
              ),
              child: Center(
                child: Icon(Icons.more_horiz,size: 16,color: AppColorData.appPrimaryColor),
              ),
            )
          ],),
          const SizedBox(height: 14,),
          Text(
              comments ?? '',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              )
          ),
          const SizedBox(height: 14,),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              color: AppColorData.transparent,
             child:  Row(
               mainAxisSize: MainAxisSize.min,
               children: [
                 SvgPicture.asset(SVGAssets.un_like_icon),
                 SizedBox(width: 10),
                 Text(
                     likeCount ?? '',
                     textAlign: TextAlign.left,
                     style: TextStyle(
                       color: AppColorData.appPrimaryColor,
                       fontSize: 14,
                       fontWeight: FontWeight.w400,
                     )
                 ),
                 SizedBox(width: 30),
                 Text(
                     commentUpdateDate ?? '',
                     textAlign: TextAlign.left,
                     style: TextStyle(
                       color: AppColorData.appPrimaryColor,
                       fontSize: 14,
                       fontWeight: FontWeight.w400,
                     )
                 ),
               ],
             ),
            ),
          ),
          const SizedBox(height: 14,),
        ],
      ),
    );
  }

}
