import 'dart:math' as math;
import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Card color presets used across the app. Names are kept from the old
/// gradient set, but each is now flat (both stops identical): white cards,
/// with [navy] as the solid deep blue accent.
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

/// Rounded card with a flat fill, soft blue-tinted shadow and
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

/// Compact stat card: a picture in the top-right corner, then a large
/// number and its label bottom-left. The picture floats slowly and grows a
/// little while the card is hovered or pressed.
class StatCard extends StatefulWidget {
  const StatCard({
    super.key,
    required this.image,
    required this.value,
    required this.label,
    required this.colors,
    this.onTap,
  });

  /// Asset path of a transparent PNG.
  final String image;
  final String value;
  final String label;
  final List<Color> colors;
  final VoidCallback? onTap;

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard> {
  bool _hover = false;
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    final fg = foregroundOn(widget.colors.first);
    // Listener/MouseRegion only observe, so PressableScale still gets taps.
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = _down = false),
      child: Listener(
        onPointerDown: (_) => setState(() => _down = true),
        onPointerUp: (_) => setState(() => _down = false),
        onPointerCancel: (_) => setState(() => _down = false),
        child: GradientCard(
          colors: widget.colors,
          onTap: widget.onTap,
          radius: AppRadius.card,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Stack(clipBehavior: Clip.none, children: [
            // Same total height as the old icon (36) + gap (12) + 22px number.
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 42),
                Text(
                  widget.value,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: fg == Colors.white ? fg : AppColors.deepBlue,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 4),
                // Shrinks a little instead of truncating ("Appointments" on narrow phones).
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    widget.label,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      color: fg == Colors.white ? fg.withValues(alpha: 0.8) : AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            // Nudged into the padding and tilted so it looks placed, not boxed.
            PositionedDirectional(
              top: -8,
              end: -6,
              child: AnimatedScale(
                scale: _hover || _down ? 1.06 : 1,
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeOut,
                child: _FloatingImage(asset: widget.image),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

/// Tilted picture with a soft blurred shadow, drifting +-3px on a 4s loop.
class _FloatingImage extends StatefulWidget {
  const _FloatingImage({required this.asset});

  final String asset;

  @override
  State<_FloatingImage> createState() => _FloatingImageState();
}

class _FloatingImageState extends State<_FloatingImage> with SingleTickerProviderStateMixin {
  static const double _height = 56;

  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(widget.asset, height: _height, fit: BoxFit.contain);
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Transform.translate(
          offset: Offset(0, 3 * math.sin(2 * math.pi * _controller.value)),
          child: child,
        ),
        child: Transform.rotate(
          angle: -0.12,
          child: Stack(children: [
            // Shadow: the same picture, tinted deep blue, blurred and offset.
            Transform.translate(
              offset: const Offset(0, 4),
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(Color(0x40064469), BlendMode.srcIn),
                  child: image,
                ),
              ),
            ),
            image,
          ]),
        ),
      ),
    );
  }
}

/// Deep blue icon on a sky blue -> mauve circle (white-on-translucent on dark cards).
class _IconBubble extends StatelessWidget {
  const _IconBubble({required this.icon, required this.onDark});

  static const double _size = 44;

  final IconData icon;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: onDark ? Colors.white.withValues(alpha: 0.2) : null,
        gradient: onDark ? null : AppColors.iconBubbleGradient,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: _size * 0.5, color: onDark ? Colors.white : AppColors.deepBlue),
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

/// Bold section heading used above groups of tiles.
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) =>
      Text(text, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: AppColors.textPrimary));
}

/// Shared list row: translucent white, soft shadow, deep blue icon on a sky blue -> mauve
/// circle (or a custom [leading]), chevron when tappable. [trailing]
/// replaces the chevron (e.g. a value or a badge). [destructive] tints the
/// icon and title red.
class AppTile extends StatelessWidget {
  const AppTile({
    super.key,
    required this.title,
    this.icon,
    this.leading,
    this.subtitle,
    this.trailing,
    this.maxSubtitleLines = 1,
    this.onTap,
    this.destructive = false,
    this.margin = const EdgeInsets.only(bottom: AppSpacing.md),
  });

  final String title;
  final IconData? icon;
  final Widget? leading;
  final String? subtitle;
  final Widget? trailing;
  final int maxSubtitleLines;
  final VoidCallback? onTap;
  final bool destructive;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    final accent = destructive ? Colors.redAccent : AppColors.deepBlue;
    return Padding(
      padding: margin,
      child: PressableScale(
        onTap: onTap,
        borderRadius: AppRadius.card,
        scale: 0.97,
        hoverScale: 1.02,
        shadows: AppShadows.soft,
        child: Container(
          color: AppColors.cardBackground,
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(children: [
            leading ??
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: destructive ? Colors.redAccent.withValues(alpha: 0.12) : null,
                    gradient: destructive ? null : AppColors.iconBubbleGradient,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: accent, size: 22),
                ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.5,
                      color: destructive ? Colors.redAccent : AppColors.textPrimary,
                    )),
                if (subtitle != null && subtitle!.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(subtitle!,
                      maxLines: maxSubtitleLines,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary)),
                ],
              ]),
            ),
            if (trailing != null) ...[const SizedBox(width: AppSpacing.sm), trailing!],
            if (trailing == null && onTap != null) const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
          ]),
        ),
      ),
    );
  }
}

/// Translucent white container for grouped content (info rows, switches).
class AppPanel extends StatelessWidget {
  const AppPanel({super.key, required this.child, this.padding = const EdgeInsets.all(AppSpacing.md)});

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: padding,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: AppShadows.soft,
        ),
        child: child,
      );
}
