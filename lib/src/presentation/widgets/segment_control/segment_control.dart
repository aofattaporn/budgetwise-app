import 'package:budget_wise/src/presentation/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';

class SegmentControl extends StatefulWidget {
  final Map<int, Widget> segmentOptions;
  final int initialSelectedIndex;
  final Color selectedColor;
  final Color unselectedColor;

  const SegmentControl({
    super.key,
    required this.segmentOptions,
    this.initialSelectedIndex = 0,
    this.selectedColor = AppColors.primary,
    this.unselectedColor = AppColors.grayLigth,
  });

  @override
  State<SegmentControl> createState() => _SegmentControlState();
}

class _SegmentControlState extends State<SegmentControl> {
  late int selectedSegment;

  @override
  void initState() {
    super.initState();
    selectedSegment = widget.initialSelectedIndex;
  }

  void handleSelected(int newValue) {
    setState(() {
      selectedSegment = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.transparent, // หรือเปลี่ยนเป็น Transparent ก็ได้
            borderRadius: BorderRadius.circular(8),
          ),
          child: CupertinoSegmentedControl<int>(
            children: widget.segmentOptions,
            groupValue: selectedSegment,
            borderColor: widget.unselectedColor,
            selectedColor: widget.selectedColor,
            unselectedColor: widget.unselectedColor,
            pressedColor: widget.unselectedColor.withOpacity(0.7),
            onValueChanged: handleSelected,
          ),
        );
      },
    );
  }
}
