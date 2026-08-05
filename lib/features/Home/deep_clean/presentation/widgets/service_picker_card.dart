import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/deep_clean/domain/models/service_item_model.dart';

class ServicePickerCard extends StatefulWidget {
  final List<ServiceItemModel> services;
  final ServiceItemModel? selected;
  final ValueChanged<ServiceItemModel?> onChanged;
  final VoidCallback? onRemove;

  const ServicePickerCard({
    super.key,
    required this.services,
    required this.selected,
    required this.onChanged,
    this.onRemove,
  });

  @override
  State<ServicePickerCard> createState() => _ServicePickerCardState();
}

class _ServicePickerCardState extends State<ServicePickerCard> {
  bool _open = false;
  final _searchCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  List<ServiceItemModel> get _filtered {
    final q = _searchCtrl.text.trim().toLowerCase();
    if (q.isEmpty) return widget.services;
    return widget.services.where((s) {
      return s.itemName.toLowerCase().contains(q) ||
          s.itemCode.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final selected = widget.selected;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ---- Search / selected field ----
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          height: 52.h,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchCtrl,
                  onTap: () => setState(() => _open = true),
                  onChanged: (_) => setState(() => _open = true),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: selected == null
                        ? 'Search service...'
                        : selected.itemName,
                    hintStyle: TextStyle(
                      color: selected == null
                          ? Colors.grey.shade600
                          : Colors.black,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  _open
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
                onPressed: () => setState(() => _open = !_open),
              ),
              if (widget.onRemove != null)
                IconButton(
                  icon: const Icon(Icons.close, size: 18),
                  color: Colors.grey,
                  onPressed: widget.onRemove,
                ),
            ],
          ),
        ),

        // ---- Dropdown panel ----
        if (_open) ...[
          8.verticalSpace,
          Container(
            constraints: BoxConstraints(maxHeight: 240.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.05),
                  blurRadius: 6,
                ),
              ],
            ),
            child: _filtered.isEmpty
                ? Padding(
                    padding: EdgeInsets.all(16.w),
                    child: const Text('No results'),
                  )
                : Scrollbar(
                    controller: _scrollCtrl,
                    thumbVisibility: true,   // always show
                    trackVisibility: true,
                    interactive: true,       // 🟢 draggable thumb
                    thickness: 5,
                    radius: const Radius.circular(4),
                    child: ListView.separated(
                      controller: _scrollCtrl,
                      padding: EdgeInsets.only(
                        top: 4.h, bottom: 4.h, left: 0, right: 8.w,
                      ),
                      shrinkWrap: true,
                      itemCount: _filtered.length,
                      separatorBuilder: (_, __) =>
                          Divider(height: 1, color: Colors.grey.shade200),
                      itemBuilder: (context, i) {
                        final s = _filtered[i];
                        final isSelected =
                            selected?.itemCode == s.itemCode;
                        return InkWell(
                          onTap: () {
                            widget.onChanged(s);
                            _searchCtrl.text = s.itemName;
                            setState(() => _open = false);
                            FocusScope.of(context).unfocus();
                          },
                          child: Container(
                            color: isSelected
                                ? Theme.of(context)
                                    .primaryColor
                                    .withOpacity(.06)
                                : null,
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 10.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  s.itemName,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                2.verticalSpace,
                                Text(
                                  s.itemCode,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ],
    );
  }
}