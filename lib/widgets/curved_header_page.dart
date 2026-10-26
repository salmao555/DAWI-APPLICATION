import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'gradient_scaffold_background.dart';

/// How far the content sheet rises over the header.
const double _sheetOverlap = 28;

/// Minimum space under the body so it clears the floating nav bar.
const double _minBottomPadding = 120;

/// Page layout: a fixed, full-width navy gradient header with square
/// bottom edges, and below it a scrolling content sheet with 32px rounded
/// top corners that overlaps the header by [_sheetOverlap]. The sheet is
/// filled with the page background gradient, so there's no seam.
///
/// [header] gets the safe-area top inset and side padding; [headerBackground]
/// (e.g. the pill pattern) is drawn behind it, clipped to the header.
/// [headerHeight] forces a height; otherwise the header sizes to its content
/// (capped so the sheet always keeps some room, e.g. with the keyboard open).
class CurvedHeaderPage extends StatelessWidget {
  const CurvedHeaderPage({
    super.key,
    required this.header,
    required this.body,
    this.headerHeight,
    this.headerBackground,
    this.onRefresh,
  });

  final Widget header;
  final Widget body;
  final double? headerHeight;
  final Widget? headerBackground;

  /// Adds pull-to-refresh to the sheet's scroll view.
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    final insets = MediaQuery.paddingOf(context);

    final headerBlock = DecoratedBox(
      decoration: const BoxDecoration(gradient: AppColors.heroGradient),
      child: Stack(children: [
        if (headerBackground != null) Positioned.fill(child: headerBackground!),
        // Never-scrolling scroll view: if the header is ever squeezed (tiny
        // window + keyboard), it clips instead of throwing an overflow.
        SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.lg,
              insets.top + AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.md + _sheetOverlap,
            ),
            child: header,
          ),
        ),
      ]),
    );

    Widget scroll = SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        math.max(_minBottomPadding, AppSpacing.xl + insets.bottom),
      ),
      child: body,
    );
    if (onRefresh != null) scroll = RefreshIndicator(onRefresh: onRefresh!, child: scroll);

    final sheet = ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      child: GradientScaffoldBackground(child: scroll),
    );

    return CustomMultiChildLayout(
      delegate: _CurvedHeaderLayout(headerHeight),
      children: [
        LayoutId(id: _Slot.header, child: ClipRect(child: headerBlock)),
        LayoutId(id: _Slot.sheet, child: sheet),
      ],
    );
  }
}

enum _Slot { header, sheet }

class _CurvedHeaderLayout extends MultiChildLayoutDelegate {
  _CurvedHeaderLayout(this.headerHeight);

  final double? headerHeight;

  @override
  void performLayout(Size size) {
    // Leave the sheet at least ~40% of the height.
    final maxHeader = math.max(_sheetOverlap, size.height * 0.6);
    final header = layoutChild(
      _Slot.header,
      headerHeight != null
          ? BoxConstraints.tightFor(width: size.width, height: math.min(headerHeight!, maxHeader))
          : BoxConstraints(minWidth: size.width, maxWidth: size.width, maxHeight: maxHeader),
    );
    positionChild(_Slot.header, Offset.zero);

    final sheetTop = math.max(0.0, header.height - _sheetOverlap);
    layoutChild(_Slot.sheet, BoxConstraints.tight(Size(size.width, size.height - sheetTop)));
    positionChild(_Slot.sheet, Offset(0, sheetTop));
  }

  @override
  bool shouldRelayout(_CurvedHeaderLayout oldDelegate) => oldDelegate.headerHeight != headerHeight;
}
