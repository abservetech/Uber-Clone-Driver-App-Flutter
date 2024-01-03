
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../common_widgets.dart';

// ignore: must_be_immutable
class ErrorDialog extends StatelessWidget {
  ErrorDialog({Key? key, required this.errorMsg, this.onBackPress})
      : super(key: key);

  var errorMsg = '';
  Function()? onBackPress;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimensions.dm_20))),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: Dimensions.dm_15),
                child: Text(
                  Strings.oopsHint,
                  style: TextStyle(
                    fontSize: Dimensions.dm_16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.dm_10,
                ),
                child: Text(
                  errorMsg,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: Dimensions.dm_14,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(Dimensions.dm_10),
            alignment: Alignment.topRight,
            child: BottomButton(
                label: Strings.okHint,
                borderRadius: Dimensions.dm_15,
                backgroundColor: ThemeColor.accentColor,
                height: Dimensions.dm_35,
                labelColor: ThemeColor.whiteColor,
                onTap: onBackPress ?? () {
                  Navigator.of(context).pop();
                }),
          ),
        ],
      ),
    );
  }

}