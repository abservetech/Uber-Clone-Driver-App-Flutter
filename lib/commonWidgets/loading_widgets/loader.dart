import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: AppColorData.appPrimaryColor,
        valueColor: AlwaysStoppedAnimation<Color>(
          AppColorData.appSecondaryColor.withOpacity(0.6),
        ),
      ),
    );
  }
}
