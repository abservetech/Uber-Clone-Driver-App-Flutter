import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/utils.dart';

Widget brandLogo(BuildContext context) {
  return Center(
    child: Hero(
      tag: 'brandLogo',
      child: SvgPicture.asset(SVGAssets.ic_brand_logo,
          height: MediaQuery.of(context).size.height * 0.14,
          width: MediaQuery.of(context).size.width * 0.4),
    ),
  );
}
