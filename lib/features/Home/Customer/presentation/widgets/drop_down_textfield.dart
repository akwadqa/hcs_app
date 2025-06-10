import 'package:flutter/material.dart';
import 'package:hcs/src/theme/app_colors.dart';

class DropDownField extends StatefulWidget {
  final bool enabled;
  final List<String> items;
  const DropDownField({super.key, this.enabled = true, required this.items});

  @override
  State<DropDownField> createState() => _DropDownFieldState();
}

class _DropDownFieldState extends State<DropDownField> {
  // final List<String> _items = ['one', 'two'];
  String? _selected;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selected,
      isDense: true,
      iconEnabledColor: AppColors.blackText,
      borderRadius: BorderRadius.circular(8),
      elevation: 8,
      items: [
        // existing items
        for (var v in widget.items)
          DropdownMenuItem(
            value: v,
            child: Text(
              _capitalize(v),
              style: Theme.of(context).inputDecorationTheme.hintStyle!.copyWith(
                color: AppColors.blackText,
              ),
            ),
          ),
      ],
      decoration: InputDecoration(
        hintText: 'Name',
        isDense: true,
        enabled: widget.enabled,
        fillColor: widget.enabled ? Colors.white : AppColors.unSelectedGrey,
      ),
      style: Theme.of(
        context,
      ).inputDecorationTheme.hintStyle!.copyWith(color: AppColors.blackText),
      onChanged:
          widget
              .enabled // ← only respond if enabled
          ? (value) {
              setState(() {
                _selected = value;
              });
            }
          : null,
    );
  }

  String _capitalize(String s) =>
      s.isEmpty ? s : (s[0].toUpperCase() + s.substring(1));
}
