import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/gen/assets.gen.dart';

/// A reusable search input styled like the app's TextFormField theme.
class SearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final VoidCallback? onClear;
  final ValueChanged<String>? onChanged;

  const SearchField({
    super.key,
    this.controller,
    this.hintText = 'Search',
    this.onClear,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        prefixIcon: Assets.images.search.svg(
          width: 16,
          height: 16,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
