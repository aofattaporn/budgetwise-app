import 'package:budget_wise/src/presentation/common/custom_common_component.dart';
import 'package:budget_wise/src/presentation/common/custum_common_widget.dart';
import 'package:budget_wise/src/presentation/components/segmented_circular_progress.dart';
import 'package:budget_wise/src/presentation/theme/system/app_colors.dart';
import 'package:flutter/material.dart';

class PlanDetailScreen extends StatefulWidget {
  const PlanDetailScreen({super.key});

  @override
  State<PlanDetailScreen> createState() => _PlanDetailScreenState();
}

class _PlanDetailScreenState extends State<PlanDetailScreen> {
  final TextEditingController planNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          _buildHeader(context, screenHeight),
          _buildFormSection(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double screenHeight) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.4,
      padding: const EdgeInsets.only(top: 48, left: 18, right: 18),
      decoration: _buildBgBoxGradient(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: AppColors.background,
            ),
          ),
          const Center(
            child: MultiSegmentCircularProgress(
              isNotfound: true,
              plan: null,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildFormSection() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            CustomCommonComponent.labelledTextFieldRow(
              textEditingController: planNameController,
              label: "Plan Name",
            ),
            const SizedBox(height: 12),
            CustomCommonComponent.labelledTextFieldRow(
              textEditingController: amountController,
              label: "Amount",
            ),
            const SizedBox(height: 12),
            CustomCommonComponent.labelledTextFieldRow(
              textEditingController: startDateController,
              label: "Start Date",
              isNumberOnly: true,
            ),
            const SizedBox(height: 12),
            CustomCommonComponent.labelledTextFieldRow(
              textEditingController: endDateController,
              label: "End Date",
              isNumberOnly: true,
            ),
            const SizedBox(height: 24),
            Spacer(),
            CustomCommonWidget.commonElevatedBtn(
              label: "Create New",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBgBoxGradient() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.primary,
          AppColors.primaryDark,
        ],
      ),
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(24),
      ),
    );
  }
}
