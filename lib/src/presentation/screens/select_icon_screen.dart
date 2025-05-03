import 'package:flutter/material.dart';
import 'package:budget_wise/src/core/utils/icon_util.dart';
import 'package:budget_wise/src/presentation/theme/app_colors.dart';

class SelectIconScreen extends StatefulWidget {
  final String initialIcon;
  final void Function(String) handleSelectIcon;

  const SelectIconScreen({
    super.key,
    required this.initialIcon,
    required this.handleSelectIcon,
  });

  @override
  State<SelectIconScreen> createState() => _SelectIconScreenState();
}

class _SelectIconScreenState extends State<SelectIconScreen> {
  String? selectedIconName;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedIconName = widget.initialIcon;
  }

  List<MapEntry<String, IconData>> get filteredIcons {
    final query = _searchController.text.toLowerCase();
    return IconUtil.allIcons.entries
        .where((entry) => entry.key.contains(query))
        .toList();
  }

  IconData get selectedIconData =>
      IconUtil.getIconByName(selectedIconName ?? '');

  void _selectIcon(String iconName) {
    widget.handleSelectIcon(iconName);
    Navigator.pop(context, iconName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Select an Icon",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  itemCount: filteredIcons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    final entry = filteredIcons[index];
                    final isSelected = selectedIconName == entry.key;

                    return _IconGridItem(
                      iconName: entry.key,
                      iconData: entry.value,
                      isSelected: isSelected,
                      onTap: () {
                        setState(() {
                          selectedIconName = entry.key;
                        });
                        _selectIcon(entry.key);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Search icon...",
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: AppColors.grayLigth.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
  }
}

class _IconGridItem extends StatelessWidget {
  final String iconName;
  final IconData iconData;
  final bool isSelected;
  final VoidCallback onTap;

  const _IconGridItem({
    required this.iconName,
    required this.iconData,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primary.withOpacity(0.2)
            : AppColors.grayLigth,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? AppColors.primary : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Center(
          child: Icon(iconData, size: 20, color: AppColors.primaryDark),
        ),
      ),
    );
  }
}
