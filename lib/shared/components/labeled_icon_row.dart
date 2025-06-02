import 'package:budget_wise/shared/utils/icon_util.dart';
import 'package:budget_wise/shared/common/custum_common_widget.dart';
import 'package:budget_wise/app_config/theme/system/app_colors.dart';
import 'package:flutter/material.dart';

class LabeledIconRow extends StatefulWidget {
  // mandatory paramm
  final String iconData;
  final void Function(String) handleSelectIcon;

  // optional paramm
  final int iconFlex;
  final int buttonFlex;
  final double spacing;

  const LabeledIconRow({
    super.key,
    required this.iconData,
    required this.handleSelectIcon,
    this.iconFlex = 3,
    this.buttonFlex = 7,
    this.spacing = 16,
  });

  @override
  State<LabeledIconRow> createState() => _LabeledIconRowState();
}

class _LabeledIconRowState extends State<LabeledIconRow> {
  final String btnMessage = 'Select Icon';

  void _navigateSelectIconScreen(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: widget.spacing,
      children: [
        Flexible(
          flex: widget.iconFlex,
          child: Center(
            child: CustomCommonWidget.boxIcon(
              iconData: IconUtil.getIconByName(widget.iconData),
            ),
          ),
        ),
        Flexible(
          flex: widget.buttonFlex,
          child: Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => _navigateSelectIconScreen(context),
              icon: const Icon(Icons.arrow_forward_outlined),
              label: Text(btnMessage),
              style: TextButton.styleFrom(
                backgroundColor: AppColors.background,
                foregroundColor: Colors.black,
                textStyle: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
