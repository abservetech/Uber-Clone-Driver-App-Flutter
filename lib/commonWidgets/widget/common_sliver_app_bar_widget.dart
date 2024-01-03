import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class CommonSliverAppBar extends StatefulWidget {
  const CommonSliverAppBar({super.key, this.appBarHeight, this.title});
  final int? appBarHeight;
  final String? title;

  @override
  State<CommonSliverAppBar> createState() => _CommonSliverAppBarState();
}

class _CommonSliverAppBarState extends State<CommonSliverAppBar> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:
          (BuildContext context, BoxConstraints constraints) {
        double percent =
        ((constraints.maxHeight - kToolbarHeight) *
            100 /
            ((widget.appBarHeight ?? 140) - kToolbarHeight));
        double dx = 0;

        dx = 100 - percent;
        if (constraints.maxHeight == 60) {
          dx = 0;
        }
        print("dx :: $dx");
        return Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: kToolbarHeight / 4, left: 0.0),
              child: Transform.translate(
                offset: Offset(
                    dx, constraints.maxHeight - kToolbarHeight),
                child: Container(
                  color: AppColorData.transparent,
                  width: (dx>15)?MediaQuery.of(context).size.width *0.78:MediaQuery.of(context).size.width *0.9,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Text(
                      widget.title ?? '',
                      maxLines: 1,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                          color: AppColorData.appPrimaryColor),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
