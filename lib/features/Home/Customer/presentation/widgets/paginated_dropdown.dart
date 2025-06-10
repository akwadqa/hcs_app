import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/Customer/data/models/customers_model.dart';
import 'package:hcs/src/theme/app_colors.dart';

/// A dropdown that displays a provided list of customers and triggers
/// Riverpod's loadMore when scrolled to the end, keeping the overlay open and
/// dynamically updating as new data arrives.
class PaginatedDropdown extends StatefulWidget {
  final List<Customers> customers;
  final bool hasMore;
  final bool isLoading;
  final VoidCallback onLoadMore;
  final bool enabled;
  final Customers? initialValue;
  final ValueChanged<Customers?>? onChanged;

  const PaginatedDropdown({
    Key? key,
    required this.customers,
    required this.hasMore,
    required this.isLoading,
    required this.onLoadMore,
    this.enabled = true,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  State<PaginatedDropdown> createState() => _PaginatedDropdownState();
}

class _PaginatedDropdownState extends State<PaginatedDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlay;
  late List<Customers> _items;
  Customers? _selected;
  late ScrollController _scrollController;
  late double _targetWidth;
  late double _targetHeight;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.customers);
    _selected = widget.initialValue;
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void didUpdateWidget(covariant PaginatedDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.customers != widget.customers) {
      _items = List.from(widget.customers);
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
    // Add null check and safe casting
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      // If renderBox is null, schedule the overlay opening for the next frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _openOverlay();
        }
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
                    final cust = _items[index];
                    return ListTile(
                      title: Text(_capitalize(cust.customerName)),
                      onTap: widget.enabled
                          ? () {
                              _selectItem(cust);
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

    // Add additional safety check before inserting overlay
    final overlay = Overlay.of(context);
    if (overlay.mounted) {
      overlay.insert(_overlay!);
    }
  }

  void _selectItem(Customers c) {
    setState(() {
      _selected = c;
    });
    widget.onChanged?.call(c);
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
            hintText: _selected?.customerName ?? 'Select Customer',
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
                  _selected?.customerName ?? '',
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

  String _capitalize(String s) =>
      s.isEmpty ? s : (s[0].toUpperCase() + s.substring(1));

  @override
  void dispose() {
    _closeOverlay(); // Clean up overlay on dispose
    _scrollController.dispose();
    super.dispose();
  }
}
