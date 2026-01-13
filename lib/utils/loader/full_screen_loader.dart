import 'package:campuspulse/utils/constants/colors.dart';
import 'package:campuspulse/utils/helpers/helper_function.dart';
import 'package:campuspulse/widgets/animation_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,

      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: CHelperFunctions.isDarkMode(Get.context!)
              ? CColors.dark
              : CColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 250),
              AnimationLoaderWidget(text: text, animation: animation),
            ],
          ),
        ),
      ),
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
