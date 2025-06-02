import 'package:flutter/material.dart';

class ButtonNavigateProps {
  final IconData icon;
  final String label;

  ButtonNavigateProps({required this.icon, required this.label});
}

class CommonBottomNavigateBar extends StatelessWidget {
  final List<ButtonNavigateProps> btnProps;
  final int currentIndex;
  final void Function(int) onTabChanged;

  const CommonBottomNavigateBar({
    super.key,
    required this.btnProps,
    required this.currentIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      color: Theme.of(context).bottomAppBarTheme.color,
      elevation: 16,
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            for (int i = 0; i < btnProps.length; i++) ...[
              if (i == btnProps.length ~/ 2)
                const Spacer(), // ช่องว่างสำหรับ FAB
              Expanded(child: _buildNavItem(context, i)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index) {
    final isSelected = currentIndex == index;
    final color = isSelected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).unselectedWidgetColor;

    return GestureDetector(
      onTap: () => onTabChanged(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(btnProps[index].icon, color: color),
          Text(
            btnProps[index].label,
            style: TextStyle(color: color, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
