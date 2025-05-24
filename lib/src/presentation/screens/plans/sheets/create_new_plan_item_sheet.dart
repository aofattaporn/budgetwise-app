import 'package:budget_wise/src/domain/models/plan_item_insert_dto.dart';
import 'package:budget_wise/src/presentation/bloc/plan_item_bloc/plan_item_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/plan_item_bloc/plan_item_event.dart';
import 'package:budget_wise/src/presentation/common/custom_common_component.dart';
import 'package:budget_wise/src/presentation/common/custum_common_widget.dart';
import 'package:budget_wise/src/presentation/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateNewPlanItemSheet extends StatefulWidget {
  final String planId;
  const CreateNewPlanItemSheet({super.key, required this.planId});

  @override
  State<CreateNewPlanItemSheet> createState() => _CreateNewPlanItemSheetState();
}

class _CreateNewPlanItemSheetState extends State<CreateNewPlanItemSheet> {
  final TextEditingController planNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  String selectedType = 'expense';
  String? selectedIcon;

  final List<String> types = ['expense', 'saving'];
  final List<String> iconOptions = ['🛒', '💰', '🍔', '🚗', '🏠'];

  bool get isFormValid =>
      planNameController.text.isNotEmpty &&
      amountController.text.isNotEmpty &&
      selectedIcon != null;

  void _onCreatePressed() {
    if (!isFormValid) return;

    final planIte = PlanItemInsertDto(
        name: planNameController.text,
        amountLimit: double.parse(amountController.text),
        type: selectedType,
        iconName: selectedIcon,
        planId: widget.planId);
    context.read<PlanItemBloc>().add(CreatePlanItem(planIte));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: types.map((type) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Row(
                        children: [
                          ChoiceChip(
                            label: Text(
                              type[0].toUpperCase() + type.substring(1),
                              style: TextStyle(
                                color: selectedType == type
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            selected: selectedType == type,
                            onSelected: (_) =>
                                setState(() => selectedType = type),
                            selectedColor: Theme.of(context).primaryColor,
                            backgroundColor: Colors.grey.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                CommonWidget.boxIcon(iconData: Icons.delete)
              ],
            ),
            const SizedBox(height: 12),

            // Icon Picker
            Wrap(
              spacing: 12,
              children: iconOptions.map((icon) {
                final isSelected = selectedIcon == icon;
                return GestureDetector(
                  onTap: () => setState(() => selectedIcon = icon),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade200,
                    child: Text(icon, style: const TextStyle(fontSize: 20)),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),

            CustomCommonComponent.labelledTextFieldRow(
              textEditingController: planNameController,
              label: "Plan Item",
            ),
            const SizedBox(height: 12),

            CustomCommonComponent.labelledTextFieldRow(
              textEditingController: amountController,
              label: "Amount",
              isNumberOnly: true,
            ),
            const Spacer(),
            CustomCommonWidget.commonElevatedBtn(
              isDisable: !isFormValid,
              label: "Create Plan Item",
              onPressed: _onCreatePressed,
            ),
          ],
        ),
      ),
    );
  }
}
