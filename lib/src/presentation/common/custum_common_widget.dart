import 'package:budget_wise/src/presentation/theme/app_colors.dart';
import 'package:budget_wise/src/presentation/theme/app_padding.dart';
import 'package:budget_wise/src/presentation/widgets/icon/box_icon.dart';
import 'package:budget_wise/src/presentation/widgets/progression/progress_bar.dart';
import 'package:budget_wise/src/presentation/widgets/segment_control/segment_control.dart';
import 'package:budget_wise/src/presentation/widgets/textField/custom_text_field.dart';
import 'package:flutter/material.dart';

class CustomCommonWidget {
  const CustomCommonWidget._();

  /// Creates a boxed icon with customizable size, color, background, and padding.
  static Widget boxIcon({
    required IconData iconData,
    double size = 20,
    Color backgroundColor = AppColors.grayLigth,
    Color iconColor = AppColors.primaryDark,
    double borderRadius = 8,
    EdgeInsetsGeometry padding = AppPadding.allmd,
  }) {
    return BoxedIcon(
      iconData: iconData,
      size: size,
      backgroundColor: backgroundColor,
      iconColor: iconColor,
      borderRadius: borderRadius,
      padding: padding,
    );
  }

  /// Creates a progress bar with customizable progress, size, colors, and radius.
  static Widget progressBar({
    required double progress,
    double height = 8,
    double borderRadius = 8,
    Color backgroundColor = AppColors.grayLigth,
    Color valueColor = AppColors.primary,
  }) {
    return ProgressBar(
      progress: progress,
      height: height,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      valueColor: valueColor,
    );
  }

  /// Creates a text-field.
  static Widget textField(
      {required TextEditingController textEditingController,
      String placeholder = ""}) {
    return CustomTextField(
      textEditingController: textEditingController,
      placeHolder: placeholder,
    );
  }

  /// Static factory method to create a default Saving/Paid Segment
  static Widget savingPaidSegment({
    required Map<int, Widget> segmentOptions,
    int initialSelectedIndex = 0,
  }) {
    return SegmentControl(
      segmentOptions: segmentOptions,
      initialSelectedIndex: initialSelectedIndex,
      selectedColor: AppColors.primary,
      unselectedColor: AppColors.grayLigth,
    );
  }
}
