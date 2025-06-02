import 'package:budget_wise/shared/theme/system/app_colors.dart';
import 'package:budget_wise/shared/theme/system/app_padding.dart';
import 'package:budget_wise/shared/widgets/bottomAppBar/custom_appbar.dart';
import 'package:budget_wise/shared/widgets/btn/common_elevated_btn.dart';
import 'package:budget_wise/shared/widgets/btn/common_floating_action_btn.dart';
import 'package:budget_wise/shared/widgets/icon/box_icon.dart';
import 'package:budget_wise/shared/widgets/progression/progress_bar.dart';
import 'package:budget_wise/shared/widgets/segment_control/segment_control.dart';
import 'package:budget_wise/shared/widgets/textField/custom_text_field.dart';
import 'package:flutter/material.dart';

class CommonWidget {
  const CommonWidget._();

  // === ICon ===
  static Widget boxIcon({
    // require paramm
    required IconData iconData,
    // optional paramm
    double size = 20,
    Color backgroundColor = AppColors.gray200,
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

  // === ICon ===
  static Widget progressBar({
    // require paramm
    required double progress,
    // optional paramm
    double height = 8,
    double borderRadius = 8,
    Color backgroundColor = AppColors.black,
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

  // === text-fied ===
  static Widget textField({
    // require paramm
    required TextEditingController textEditingController,
    // optional paramm
    String placeholder = "",
    bool isNumberOnly = false,
  }) {
    return CustomTextField(
      textEditingController: textEditingController,
      placeHolder: placeholder,
      isNumberOnly: isNumberOnly,
    );
  }

  // === segment ===
  static Widget segmentControl({
    // require paramm
    required Map<int, String> segmentOptions,
    required Function(int) handleSelectSegment,
    // optional paramm
    int initialSelectedIndex = 0,
  }) {
    return SegmentControl(
      segmentOptions: segmentOptions,
      initialSelectedIndex: initialSelectedIndex,
      selectedColor: AppColors.primary,
      unselectedColor: AppColors.black,
      handleSelectSegment: handleSelectSegment,
    );
  }

  // === btn ===
  static Widget commonElevatedBtn({
    // require paramm
    required String label,
    required void Function() onPressed,
    // not-require paramm
    bool? isDisable = true,
  }) {
    return CommonElevatedBtn(
      label: label,
      onPressed: onPressed,
      isDisable: isDisable,
    );
  }

  static Widget commonFloatingActionButton({
    // require paramm
    required VoidCallback onPressed,
    required IconData icon,
    // not-require paramm
    ShapeBorder? shape,
  }) {
    return CommonFloatingActionButton(
      onPressed: onPressed,
      icon: icon,
      shape: shape,
    );
  }

  static Widget commonBottomNavigateBar({
    required List<ButtonNavigateProps> btnProps,
    required int currentIndex,
    required void Function(int) onTabChanged,
  }) {
    return CommonBottomNavigateBar(
      btnProps: btnProps,
      currentIndex: currentIndex,
      onTabChanged: onTabChanged,
    );
  }
}
