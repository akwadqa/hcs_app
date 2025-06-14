import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/src/theme/app_colors.dart';
import 'package:hcs/features/Home/Driver_Payment/data/models/drivers_model.dart';

class PaginatedDriverDropdown extends StatefulWidget {
  final List<Driver> drivers;
  final bool hasMore;
  final bool isLoading;
  final VoidCallback onLoadMore;
  final bool enabled;
  final Driver? initialValue;
  final ValueChanged<Driver?>? onChanged;

  const PaginatedDriverDropdown({
    super.key,
    required this.drivers,
    required this.hasMore,
    required this.isLoading,
    required this.onLoadMore,
    this.enabled = true,
    this.initialValue,
    this.onChanged,
  });

  @override
  State<PaginatedDriverDropdown> createState() => _PaginatedDriverDropdownState();
}

class _PaginatedDriverDropdownState extends State<PaginatedDriverDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlay;
  late List<Driver> _items;
  Driver? _selected;
  late ScrollController _scrollController;
  late double _targetWidth;
  late double _targetHeight;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.drivers);
    _selected = widget.initialValue;
    _scrollController = ScrollController()..addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _initOverlay());
  }

  void _initOverlay() {
    if (mounted) {
      _openOverlay();
    }
  }

  @override
  void didUpdateWidget(covariant PaginatedDriverDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.drivers != widget.drivers) {
      _items = List.from(widget.drivers);
      if (_overlay != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _overlay?.markNeedsBuild();
        });
      }
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >
            _scrollController.position.maxScrollExtent - 100 &&
        !widget.isLoading &&
        widget.hasMore) {
      widget.onLoadMore();
    }
  }

  void _openOverlay() {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _openOverlay();
      });
      return;
    }

    _targetWidth = renderBox.size.width;
    _targetHeight = renderBox.size.height;

    _overlay = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: _targetWidth,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, _targetHeight + 5),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 300.h,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _items.length + (widget.hasMore ? 1 : 0),
                  itemBuilder: (_, index) {
                    if (index >= _items.length) {
                      return const Padding(
                        padding: EdgeInsets.all(8),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final driver = _items[index];
                    return ListTile(
                      title: Text(_capitalize(driver.fullName)),
                      onTap: widget.enabled
                          ? () {
                              _selectItem(driver);
                              _closeOverlay();
                            }
                          : null,
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );

    final overlay = Overlay.of(context);
    if (overlay.mounted) {
      overlay.insert(_overlay!);
    }
  }

  void _selectItem(Driver d) {
    setState(() {
      _selected = d;
    });
    widget.onChanged?.call(d);
  }

  void _closeOverlay() {
    _overlay?.remove();
    _overlay = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: widget.enabled
            ? () {
                if (_overlay == null) {
                  _openOverlay();
                } else {
                  _closeOverlay();
                }
              }
            : null,
        child: InputDecorator(
          decoration: InputDecoration(
            hintText: _selected?.fullName ?? 'Select Driver',
            isDense: true,
            enabled: widget.enabled,
            filled: true,
            fillColor: widget.enabled ? Colors.white : AppColors.unSelectedGrey,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  _selected?.fullName ?? '',
                  style: Theme.of(context).inputDecorationTheme.hintStyle!
                      .copyWith(color: AppColors.blackText),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                _overlay == null ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                color: AppColors.blackText,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _capitalize(String s) => s.isEmpty ? s : (s[0].toUpperCase() + s.substring(1));

  @override
  void dispose() {
    _closeOverlay();
    _scrollController.dispose();
    super.dispose();
  }
}