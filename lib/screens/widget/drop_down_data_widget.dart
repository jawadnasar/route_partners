import 'package:flutter/material.dart';
import 'package:route_partners/core/constants/app_colors.dart';

class DropdownDataWidget<T> extends StatelessWidget {
  final String? hint;
  final List<T> items;
  final T? selectedValue;
  final ValueChanged<T?> onChanged;
  final String Function(T)
      itemTextExtractor; // Function to extract display text

  // ignore: use_key_in_widget_constructors
  const DropdownDataWidget({
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    required this.itemTextExtractor, this.hint, // Add this parameter
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<T>(
        
        hint: Text('$hint'),
        underline: const SizedBox.shrink(),
        value: selectedValue,
        isExpanded: true,
        menuMaxHeight: 200,
        
        icon: const Icon(Icons.arrow_drop_down),
        items: items.map((item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(
              itemTextExtractor(
                  item), // Extract display text using the function
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: kBlackColor),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}