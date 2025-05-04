import 'package:budget_wise/src/presentation/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';

class SegmentControl extends StatefulWidget {
  final Map<int, String> segmentOptions;
  final Function(int) handleSelectSegment;
  final int initialSelectedIndex;
  final Color selectedColor;
  final Color unselectedColor;

  const SegmentControl({
    super.key,
    required this.segmentOptions,
    this.initialSelectedIndex = 0,
    this.selectedColor = AppColors.primary,
    this.unselectedColor = AppColors.grayLigth,
    required this.handleSelectSegment,
  });

  @override
  State<SegmentControl> createState() => _SegmentControlState();
}

class _SegmentControlState extends State<SegmentControl> {
  Map<int, Widget> convertToMapWidget(Map<int, String> segment) {
    return segment.map((key, value) => MapEntry(key, Text(value)));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: CupertinoSegmentedControl<int>(
            children: convertToMapWidget(widget.segmentOptions),
            groupValue: widget.initialSelectedIndex,
            borderColor: widget.unselectedColor,
            selectedColor: widget.selectedColor,
            unselectedColor: widget.unselectedColor,
            pressedColor: widget.unselectedColor.withOpacity(0.7),
            onValueChanged: widget.handleSelectSegment,
          ),
        );
      },
    );
  }
}
