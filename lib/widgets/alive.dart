import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Card color presets used across the app. Names are kept from the old
/// gradient set, but each is now flat (both stops identical): white cards,
/// with [navy] as the solid deep-teal accent.
class AppGradients {
  AppGradients._();

  static const teal = [Colors.white, Colors.white];
  static const lilac = [Colors.white, Colors.white];
  static const peach = [Colors.white, Colors.white];
  static const mint = [Colors.white, Colors.white];
  static const navy = [AppColors.deepTeal, AppColors.deepTeal];
}

/// Readable foreground (dark text or white) for a given card background.
Color foregroundOn(Color background) =>
    background.computeLuminance() > 0.4 ? AppColors.textPrimary : Colors.white;

/// Wraps any child: grows slightly on hover (web/desktop), shrinks and
/// darkens while pressed.
class PressableScale extends StatefulWidget {
  const PressableScale({
    super.key,
    required this.child,
    this.onTap,
    this.scale = 0.95,
    this.hoverScale = 1.04,
    this.borderRadius = 24,
    this.shadows,
  });

  final Widget child;
  final VoidCallback? onTap;
  final double scale;
  final double hoverScale;
  final double borderRadius;

  /// Optional shadow drawn outside the clip, so it scales with the child.
  final List<BoxShadow>? shadows;

  @override
  State<PressableScale> createState() => _PressableScaleState();
}

class _PressableScaleState extends State<PressableScale> {
  static const _duration = Duration(milliseconds: 150);

  bool _down = false;
  bool _hover = false;

  void _setDown(bool v) {
    if (_down != v) setState(() => _down = v);
  }

  void _setHover(bool v) {
    if (_hover != v) setState(() => _hover = v);
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(widget.borderRadius);
    final scale = _down
        ? widget.scale
        : _hover
            ? widget.hoverScale
            : 1.0;

    return MouseRegion(
      cursor: widget.onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: (_) => _setHover(true),
      onExit: (_) {
        _setHover(false);
        _setDown(false);
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => _setDown(true),
        onTapUp: (_) => _setDown(false),
        onTapCancel: () => _setDown(false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: scale,
          duration: _duration,
          curve: Curves.easeOut,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: radius,
              boxShadow: widget.shadows,
            ),
            child: ClipRRect(
              borderRadius: radius,
              child: Stack(
                children: [
                  widget.child,
                  Positioned.fill(
                    child: IgnorePointer(
                      child: AnimatedOpacity(
                        opacity: _down ? 1 : 0,
                        duration: _duration,
                        child: ColoredBox(
                          color: AppColors.textPrimary.withValues(alpha: 0.08),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Rounded card with a flat fill, soft teal-tinted shadow and
/// hover/press effect. A gradient is only drawn if [colors] differ.
class GradientCard extends StatelessWidget {
  const GradientCard({
    super.key,
    required this.colors,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.radius = AppRadius.card,
  });

  final List<Color> colors;
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final flat = colors.every((c) => c == colors.first);
    return PressableScale(
      onTap: onTap,
      borderRadius: radius,
      shadows: AppShadows.soft,
      child: Container(
        width: double.infinity,
        padding: padding,
        decoration: BoxDecoration(
          color: flat ? colors.first : null,
          gradient: flat
              ? null
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: colors,
                ),
        ),
        child: child,
      ),
    );
  }
}

/// Compact stat card: icon bubble, number, short label.
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.colors,
    this.onTap,
  });

  final IconData icon;
  final String value;
  final String label;
  final List<Color> colors;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final fg = foregroundOn(colors.first);
    return GradientCard(
      colors: colors,
      onTap: onTap,
      radius: AppRadius.card,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _IconBubble(icon: icon, onDark: fg == Colors.white, size: 36),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: fg,
              height: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: fg == Colors.white ? fg.withValues(alpha: 0.8) : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Teal icon on a mint circle (white-on-translucent on dark cards).
class _IconBubble extends StatelessWidget {
  const _IconBubble({required this.icon, required this.onDark, this.size = 44});

  final IconData icon;
  final bool onDark;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: onDark ? Colors.white.withValues(alpha: 0.2) : AppColors.mint,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: size * 0.5, color: onDark ? Colors.white : AppColors.teal),
    );
  }
}

/// Square-ish quick action button (icon + label).
class QuickActionTile extends StatelessWidget {
  const QuickActionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.colors,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final List<Color> colors;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final fg = foregroundOn(colors.first);
    return GradientCard(
      colors: colors,
      onTap: onTap,
      radius: AppRadius.card,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _IconBubble(icon: icon, onDark: fg == Colors.white),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}

/// Fade + slide-up entrance. Use index to stagger items.
class FadeSlideIn extends StatelessWidget {
  const FadeSlideIn({super.key, required this.child, this.index = 0});

  final Widget child;
  final int index;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 450 + index * 90),
      curve: Curves.easeOutCubic,
      builder: (context, t, c) => Opacity(
        opacity: t,
        child: Transform.translate(offset: Offset(0, 24 * (1 - t)), child: c),
      ),
      child: child,
    );
  }
}
