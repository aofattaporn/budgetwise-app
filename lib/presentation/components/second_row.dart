import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:budget_wise/app_config/theme/system/app_colors.dart';

class SecondRow extends StatelessWidget {
  final dynamic viewType;
  final DateTime selectedDate;
  final DateTime selectedWeek;
  final DateTime selectedMonth;
  final ValueChanged<DateTime> onDateChipSelected;
  final Future<void> Function(BuildContext) onPickDate;
  final VoidCallback onPrevWeek;
  final VoidCallback onNextWeek;
  final Future<void> Function(BuildContext) onPickWeek;
  final VoidCallback onPrevMonth;
  final VoidCallback onNextMonth;
  final Future<void> Function(BuildContext) onPickMonth;
  const SecondRow(
      {required this.viewType,
      required this.selectedDate,
      required this.selectedWeek,
      required this.selectedMonth,
      required this.onDateChipSelected,
      required this.onPickDate,
      required this.onPrevWeek,
      required this.onNextWeek,
      required this.onPickWeek,
      required this.onPrevMonth,
      required this.onNextMonth,
      required this.onPickMonth,
      super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (viewType.toString() == 'TransactionViewType.date') {
      final today = DateTime.now();
      final yesterday = today.subtract(const Duration(days: 1));
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ChoiceChip(
                label: Text(
                  'Yesterday',
                  style: TextStyle(
                    fontWeight: selectedDate.year == yesterday.year &&
                            selectedDate.month == yesterday.month &&
                            selectedDate.day == yesterday.day
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: selectedDate.year == yesterday.year &&
                            selectedDate.month == yesterday.month &&
                            selectedDate.day == yesterday.day
                        ? Colors.white
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                selected: selectedDate.year == yesterday.year &&
                    selectedDate.month == yesterday.month &&
                    selectedDate.day == yesterday.day,
                selectedColor: AppColors.primaryDark,
                backgroundColor: Colors.transparent,
                onSelected: (_) => onDateChipSelected(yesterday),
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                label: Text(
                  'Today',
                  style: TextStyle(
                    fontWeight: selectedDate.year == today.year &&
                            selectedDate.month == today.month &&
                            selectedDate.day == today.day
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: selectedDate.year == today.year &&
                            selectedDate.month == today.month &&
                            selectedDate.day == today.day
                        ? Colors.white
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                selected: selectedDate.year == today.year &&
                    selectedDate.month == today.month &&
                    selectedDate.day == today.day,
                selectedColor: AppColors.primaryDark,
                backgroundColor: Colors.transparent,
                onSelected: (_) => onDateChipSelected(today),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  side: BorderSide(color: colorScheme.primary),
                ),
                icon: const Icon(Icons.calendar_today, size: 18),
                label: Text(DateFormat('yyyy-MM-dd').format(selectedDate),
                    style: Theme.of(context).textTheme.bodySmall),
                onPressed: () => onPickDate(context),
              ),
            ],
          ),
        ),
      );
    } else if (viewType.toString() == 'TransactionViewType.week') {
      final weekStart =
          selectedWeek.subtract(Duration(days: selectedWeek.weekday - 1));
      final weekEnd = weekStart.add(const Duration(days: 6));
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: onPrevWeek,
              ),
              Text(
                '${DateFormat('MMM d').format(weekStart)} - ${DateFormat('MMM d, yyyy').format(weekEnd)}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: onNextWeek,
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  side: BorderSide(color: colorScheme.primary),
                ),
                icon: const Icon(Icons.calendar_today, size: 18),
                label: const Text('Pick Week'),
                onPressed: () => onPickWeek(context),
              ),
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: onPrevMonth,
              ),
              Text(
                DateFormat('MMMM yyyy').format(selectedMonth),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: onNextMonth,
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  side: BorderSide(color: colorScheme.primary),
                ),
                icon: const Icon(Icons.calendar_today, size: 18),
                label: const Text('Pick Month'),
                onPressed: () => onPickMonth(context),
              ),
            ],
          ),
        ),
      );
    }
  }
}
