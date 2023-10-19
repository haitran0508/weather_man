import 'package:flutter/material.dart';

import '../constants/colors.dart';

enum DualSegmentSelection { left, right }

class DualSegment extends StatefulWidget {
  final DualSegmentSelection selection;

  final void Function(DualSegmentSelection selection)? onSelectionChanged;

  final String leftLabel;

  final String rightLabel;

  const DualSegment({
    super.key,
    required this.selection,
    this.onSelectionChanged,
    required this.leftLabel,
    required this.rightLabel,
  });

  @override
  State<DualSegment> createState() => _DualSegmentState();
}

class _DualSegmentState extends State<DualSegment> {
  late DualSegmentSelection _selection;

  final _selectedTextStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  final _unSelectedTextStyle = const TextStyle(
    color: Color(0xFF9399A2),
    fontWeight: FontWeight.normal,
  );

  @override
  void initState() {
    super.initState();
    _selection = widget.selection;
  }

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.all(8);
    const radius = BorderRadius.all(Radius.circular(15));
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => _onChanged(DualSegmentSelection.left),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: (_selection == DualSegmentSelection.left) ? AppColors.secondaryColor : Colors.transparent,
              borderRadius: radius,
            ),
            child: Padding(
              padding: padding,
              child: Text(
                widget.leftLabel,
                style: (_selection == DualSegmentSelection.left) ? _selectedTextStyle : _unSelectedTextStyle,
              ),
            ),
          ),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () => _onChanged(DualSegmentSelection.right),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: (_selection == DualSegmentSelection.right) ? AppColors.secondaryColor : Colors.transparent,
              borderRadius: radius,
            ),
            child: Padding(
              padding: padding,
              child: Text(
                widget.rightLabel,
                style: (_selection == DualSegmentSelection.right) ? _selectedTextStyle : _unSelectedTextStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onChanged(DualSegmentSelection selection) {
    setState(() => _selection = selection);
    widget.onSelectionChanged?.call(selection);
  }
}
