import 'dart:math' as math;

import 'package:flutter/material.dart';

/// One scattered icon: position as a fraction of the area, size, rotation
/// (radians), float period in seconds and phase offset.
class _Pill {
  final IconData icon;
  final double x;
  final double y;
  final double size;
  final double rotation;
  final int period;
  final double phase;
  const _Pill(this.icon, this.x, this.y, this.size, this.rotation, this.period, this.phase);
}

const _pills = [
  _Pill(Icons.medication_rounded, 0.08, 0.06, 40, -0.5, 5, 0.0),
  _Pill(Icons.add_rounded, 0.32, 0.14, 24, 0.0, 4, 0.3),
  _Pill(Icons.vaccines_rounded, 0.72, 0.05, 48, 0.6, 6, 0.6),
  _Pill(Icons.healing_rounded, 0.92, 0.22, 32, -0.3, 5, 0.1),
  _Pill(Icons.medication_liquid_rounded, 0.16, 0.30, 52, 0.25, 6, 0.8),
  _Pill(Icons.add_rounded, 0.55, 0.28, 28, 0.0, 4, 0.5),
  _Pill(Icons.medication_rounded, 0.82, 0.42, 56, 1.1, 5, 0.2),
  _Pill(Icons.healing_rounded, 0.06, 0.52, 30, 0.8, 4, 0.9),
  _Pill(Icons.vaccines_rounded, 0.40, 0.48, 36, -0.9, 6, 0.4),
  _Pill(Icons.add_rounded, 0.94, 0.64, 26, 0.0, 5, 0.7),
  _Pill(Icons.medication_liquid_rounded, 0.62, 0.70, 44, -0.4, 4, 0.15),
  _Pill(Icons.medication_rounded, 0.20, 0.78, 34, 0.4, 6, 0.55),
  _Pill(Icons.healing_rounded, 0.84, 0.88, 50, -1.0, 5, 0.35),
  _Pill(Icons.add_rounded, 0.42, 0.93, 30, 0.0, 6, 0.75),
];

/// Decorative scattered medical icons that drift up and down slowly.
/// Fills its parent; put it under the content in a Stack. Ignores pointers
/// and is hidden from screen readers.
class PillBackground extends StatefulWidget {
  const PillBackground({super.key, this.color = Colors.white, this.opacity = 0.09});

  final Color color;
  final double opacity;

  @override
  State<PillBackground> createState() => _PillBackgroundState();
}

class _PillBackgroundState extends State<PillBackground> with SingleTickerProviderStateMixin {
  // 60s is a multiple of every period (4/5/6s), so the loop is seamless.
  static const _loopSeconds = 60;
  static const _drift = 8.0;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: _loopSeconds),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color.withValues(alpha: widget.opacity);
    return IgnorePointer(
      child: ExcludeSemantics(
        child: RepaintBoundary(
          child: LayoutBuilder(
            builder: (context, constraints) => AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                final seconds = _controller.value * _loopSeconds;
                return Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    for (final p in _pills)
                      Positioned(
                        left: p.x * constraints.maxWidth - p.size / 2,
                        top:
                            p.y * constraints.maxHeight -
                            p.size / 2 +
                            _drift * math.sin(2 * math.pi * (seconds / p.period + p.phase)),
                        child: Transform.rotate(
                          angle: p.rotation,
                          child: Icon(p.icon, size: p.size, color: color),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
