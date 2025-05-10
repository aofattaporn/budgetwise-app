// import 'package:budget_wise/src/core/utils/icon_util.dart';
// import 'package:budget_wise/src/domain/models/plan_item_dto.dart';
// import 'package:budget_wise/src/presentation/bloc/plan_item_bloc/plan_item_bloc.dart';
// import 'package:budget_wise/src/presentation/bloc/plan_item_bloc/plan_item_event.dart';
// import 'package:budget_wise/src/presentation/common/custom_common_dailog.dart';
// import 'package:budget_wise/src/presentation/common/custom_common_sheet.dart';
// import 'package:budget_wise/src/presentation/common/custum_common_widget.dart';
// import 'package:budget_wise/src/presentation/components/amount_compare.dart';
// import 'package:budget_wise/src/presentation/theme/app_text_style.dart';
// import 'package:flutter/material.dart';
// import 'package:budget_wise/src/presentation/theme/app_colors.dart';
// import 'package:budget_wise/src/domain/entities/plan_item_temp_entity.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class PlanItemCard extends StatelessWidget {
//   final PlanItemEntity item;
//   final double progress;

//   const PlanItemCard({
//     super.key,
//     required this.item,
//     required this.progress,
//   });

//   void _handleOnEdit(BuildContext context) {
//     Navigator.pop(context);
//     CustomCommonSheet().createNewPlanItem(context,
//         planId: item.planId,
//         id: item.id,
//         planItemDto: PlanItemDto.fromEntity(item));
//   }

//   void _handleOnDelete(BuildContext context) {
//     CustomCommonDialog().confirmDeleteDialog(
//       context,
//       title: "Delete Plan Item?",
//       message:
//           "Are you sure you want to permanently delete this plan item? This action cannot be undone.",
//       onConfirm: () {
//         context
//             .read<PlanItemBloc>()
//             .add(DeletePlanItemById(planItemId: item.id, planId: item.planId));
//         Navigator.pop(context);
//       },
//     );
//   }

//   void _optionPlanItemCard(BuildContext context) {
//     CustomCommonSheet(height: null).optionPlanItemSheet(context,
//         onEdit: _handleOnEdit, onDelete: _handleOnDelete);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         spacing: 12,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _buildTitleAndUsage(),
//               IconButton(
//                 icon: const Icon(Icons.more_vert),
//                 onPressed: () => _optionPlanItemCard(context),
//               ),
//             ],
//           ),
//           CustomCommonWidget.progressBar(progress: progress)
//         ],
//       ),
//     );
//   }

//   Widget _buildTitleAndUsage() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       spacing: 4,
//       children: [
//         Row(
//           spacing: 12,
//           children: [
//             CustomCommonWidget.boxIcon(
//                 iconData: IconUtil.getIconByName(item.iconName)),
//             Text(
//               item.title,
//               style: AppTextStyles.headlineSmall,
//             ),
//           ],
//         ),
//         AmountCompare(usage: item.usage, limitAmount: item.planAmount),
//       ],
//     );
//   }
// }
