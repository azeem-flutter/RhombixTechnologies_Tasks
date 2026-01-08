import 'package:campuspulse/utils/constants/colors.dart';
import 'package:campuspulse/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TabSelectorWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;
  final List<String> tabs;

  const TabSelectorWidget({
    Key? key,
    required this.selectedIndex,
    required this.onTabSelected,
    this.tabs = const ['All Events', 'Today', 'Important'],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: CSizes.lg),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = selectedIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(index),
              child: Container(
                margin: EdgeInsets.only(
                  right: index < tabs.length - 1 ? 10 : 0,
                ),
                padding: const EdgeInsets.symmetric(vertical: CSizes.md),
                decoration: BoxDecoration(
                  color: isSelected ? CColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(CSizes.sm),
                  border: Border.all(
                    color: isSelected ? CColors.primary : Colors.grey[300]!,
                  ),
                ),
                child: Text(
                  tabs[index],
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isSelected ? CColors.white : CColors.black,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
