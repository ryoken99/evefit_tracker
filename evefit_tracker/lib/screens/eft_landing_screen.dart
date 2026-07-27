import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/eft_visual_identity.dart';

class EftLandingScreen extends StatefulWidget {
  const EftLandingScreen({super.key, required this.onContinue});

  final VoidCallback onContinue;

  @override
  State<EftLandingScreen> createState() => _EftLandingScreenState();
}

class _EftLandingScreenState extends State<EftLandingScreen>
    with TickerProviderStateMixin {
  late final AnimationController _introController;
  late final AnimationController _ambientController;
  bool _reduceMotion = false;
  bool _continuing = false;

  @override
  void initState() {
    super.initState();
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    _ambientController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mediaQuery = MediaQuery.of(context);
    final reduceMotion =
        mediaQuery.disableAnimations || mediaQuery.accessibleNavigation;
    if (reduceMotion == _reduceMotion &&
        (_introController.isAnimating ||
            _introController.isCompleted ||
            _introController.value == 1)) {
      return;
    }

    _reduceMotion = reduceMotion;
    if (_reduceMotion) {
      _introController.value = 1;
      _ambientController
        ..stop()
        ..value = 0.5;
    } else {
      _introController.forward();
      _ambientController.repeat();
    }
  }

  @override
  void dispose() {
    _introController.dispose();
    _ambientController.dispose();
    super.dispose();
  }

  void _continue() {
    if (_continuing) return;
    _continuing = true;
    widget.onContinue();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final compact = mediaQuery.size.height < 520;
    final logoSize = compact ? 76.0 : 112.0;

    return Scaffold(
      backgroundColor: const Color(0xFF161321),
      body: DecoratedBox(
        key: const ValueKey('eft_landing_screen'),
        decoration: const BoxDecoration(
          gradient: EftVisualIdentity.landingGradient,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            RepaintBoundary(
              child: AnimatedBuilder(
                key: const ValueKey('eft_landing_network'),
                animation: _ambientController,
                builder: (context, _) => CustomPaint(
                  painter: _EftLivingNetworkPainter(
                    phase: _ambientController.value,
                  ),
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, -0.26),
                  radius: 0.62,
                  colors: [
                    EftVisualIdentity.gold.withValues(alpha: 0.13),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Semantics(
                key: const ValueKey('eft_landing_continue'),
                button: true,
                label: 'Continuar para a seleção de perfil',
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    key: const ValueKey('eft_landing_tap_surface'),
                    onTap: _continue,
                    splashColor: EftVisualIdentity.gold.withValues(alpha: 0.12),
                    highlightColor: EftVisualIdentity.gold.withValues(
                      alpha: 0.07,
                    ),
                    child: FadeTransition(
                      opacity: CurvedAnimation(
                        parent: _introController,
                        curve: Curves.easeOut,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: compact ? 20 : 28,
                          vertical: compact ? 14 : 24,
                        ),
                        child: Column(
                          children: [
                            const Spacer(flex: 3),
                            Semantics(
                              header: true,
                              label: 'EFT',
                              child: _EftWordmark(fontSize: logoSize),
                            ),
                            const Spacer(flex: 4),
                            _ContinuePrompt(compact: compact),
                            SizedBox(height: compact ? 8 : 18),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EftWordmark extends StatelessWidget {
  const _EftWordmark({required this.fontSize});

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: fontSize,
      height: 1,
      fontWeight: FontWeight.w800,
      color: Colors.white,
      shadows: const [
        Shadow(color: Color(0xB3000000), offset: Offset(0, 5), blurRadius: 14),
        Shadow(color: Color(0x594A2F68), offset: Offset(0, -2), blurRadius: 8),
      ],
    );

    return RepaintBoundary(
      key: const ValueKey('eft_landing_wordmark'),
      child: ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) => const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF7F2E7),
            Color(0xFFE2C985),
            Color(0xFFA8CFE5),
            Color(0xFFEEE5D1),
          ],
          stops: [0, 0.42, 0.7, 1],
        ).createShader(bounds),
        child: Text('EFT', style: textStyle),
      ),
    );
  }
}

class _ContinuePrompt extends StatelessWidget {
  const _ContinuePrompt({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      key: const ValueKey('eft_landing_continue_prompt'),
      constraints: const BoxConstraints(minHeight: 52, maxWidth: 280),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0x66131220),
          border: Border.all(color: EftVisualIdentity.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 16 : 20,
            vertical: 12,
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.touch_app_outlined,
                size: 20,
                color: EftVisualIdentity.gold,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  'Tocar para continuar',
                  style: TextStyle(
                    color: EftVisualIdentity.foreground,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EftLivingNetworkPainter extends CustomPainter {
  const _EftLivingNetworkPainter({required this.phase});

  final double phase;
  static final _filaments = _buildEftFilaments();

  static const _branches = <_EftBranch>[
    // Five trunks grow inwards from the edges and frame the EFT wordmark.
    _EftBranch(
      Offset(-0.04, 0.82),
      Offset(0.08, 0.78),
      Offset(0.17, 0.57),
      Offset(0.39, 0.48),
      flowOffset: 0.08,
    ),
    _EftBranch(
      Offset(-0.04, 0.15),
      Offset(0.09, 0.13),
      Offset(0.22, 0.35),
      Offset(0.40, 0.43),
      flowOffset: 0.31,
    ),
    _EftBranch(
      Offset(0.45, -0.05),
      Offset(0.53, 0.12),
      Offset(0.39, 0.29),
      Offset(0.47, 0.40),
      flowOffset: 0.54,
    ),
    _EftBranch(
      Offset(1.04, 0.12),
      Offset(0.89, 0.14),
      Offset(0.76, 0.34),
      Offset(0.60, 0.43),
      flowOffset: 0.72,
    ),
    _EftBranch(
      Offset(1.04, 0.84),
      Offset(0.89, 0.80),
      Offset(0.76, 0.58),
      Offset(0.61, 0.48),
      flowOffset: 0.9,
    ),

    // Secondary branches create restrained Y-shaped bifurcations.
    _EftBranch(
      Offset(0.14, 0.68),
      Offset(0.10, 0.62),
      Offset(0.05, 0.59),
      Offset(0.03, 0.52),
      level: 1,
    ),
    _EftBranch(
      Offset(0.14, 0.68),
      Offset(0.20, 0.65),
      Offset(0.24, 0.72),
      Offset(0.28, 0.76),
      level: 1,
    ),
    _EftBranch(
      Offset(0.17, 0.29),
      Offset(0.12, 0.29),
      Offset(0.08, 0.36),
      Offset(0.03, 0.38),
      level: 1,
    ),
    _EftBranch(
      Offset(0.17, 0.29),
      Offset(0.23, 0.27),
      Offset(0.27, 0.20),
      Offset(0.34, 0.18),
      level: 1,
    ),
    _EftBranch(
      Offset(0.46, 0.19),
      Offset(0.41, 0.18),
      Offset(0.39, 0.12),
      Offset(0.34, 0.09),
      level: 1,
    ),
    _EftBranch(
      Offset(0.46, 0.19),
      Offset(0.51, 0.18),
      Offset(0.56, 0.12),
      Offset(0.61, 0.10),
      level: 1,
    ),
    _EftBranch(
      Offset(0.80, 0.27),
      Offset(0.85, 0.28),
      Offset(0.88, 0.35),
      Offset(0.94, 0.37),
      level: 1,
    ),
    _EftBranch(
      Offset(0.80, 0.27),
      Offset(0.75, 0.24),
      Offset(0.72, 0.18),
      Offset(0.67, 0.16),
      level: 1,
    ),
    _EftBranch(
      Offset(0.83, 0.69),
      Offset(0.88, 0.67),
      Offset(0.91, 0.60),
      Offset(0.97, 0.58),
      level: 1,
    ),
    _EftBranch(
      Offset(0.83, 0.69),
      Offset(0.77, 0.67),
      Offset(0.73, 0.74),
      Offset(0.67, 0.76),
      level: 1,
    ),

    // Sparse tertiary growth keeps the silhouette organic without adding noise.
    _EftBranch(
      Offset(0.03, 0.52),
      Offset(0.01, 0.49),
      Offset(0.02, 0.44),
      Offset(0.06, 0.42),
      level: 2,
    ),
    _EftBranch(
      Offset(0.03, 0.52),
      Offset(0.06, 0.55),
      Offset(0.07, 0.61),
      Offset(0.11, 0.63),
      level: 2,
    ),
    _EftBranch(
      Offset(0.34, 0.18),
      Offset(0.31, 0.15),
      Offset(0.29, 0.11),
      Offset(0.31, 0.07),
      level: 2,
    ),
    _EftBranch(
      Offset(0.61, 0.10),
      Offset(0.64, 0.07),
      Offset(0.69, 0.06),
      Offset(0.72, 0.08),
      level: 2,
    ),
    _EftBranch(
      Offset(0.94, 0.37),
      Offset(0.97, 0.35),
      Offset(0.98, 0.31),
      Offset(0.96, 0.28),
      level: 2,
    ),
    _EftBranch(
      Offset(0.67, 0.76),
      Offset(0.65, 0.80),
      Offset(0.66, 0.85),
      Offset(0.70, 0.87),
      level: 2,
    ),
  ];

  static const _synapses = <_EftSynapse>[
    _EftSynapse(Offset(0.14, 0.68), 0.8),
    _EftSynapse(Offset(0.17, 0.29), 0.9),
    _EftSynapse(Offset(0.46, 0.19), 0.75),
    _EftSynapse(Offset(0.80, 0.27), 0.8),
    _EftSynapse(Offset(0.83, 0.69), 0.85),
    _EftSynapse(Offset(0.39, 0.48), 1),
    _EftSynapse(Offset(0.40, 0.43), 1),
    _EftSynapse(Offset(0.47, 0.40), 1),
    _EftSynapse(Offset(0.60, 0.43), 1),
    _EftSynapse(Offset(0.61, 0.48), 1),
    _EftSynapse(Offset(0.03, 0.52), 0.65),
    _EftSynapse(Offset(0.28, 0.76), 0.55),
    _EftSynapse(Offset(0.34, 0.18), 0.55),
    _EftSynapse(Offset(0.61, 0.10), 0.55),
    _EftSynapse(Offset(0.94, 0.37), 0.55),
    _EftSynapse(Offset(0.67, 0.76), 0.55),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final branchShader = const LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        Color(0x005C9BC8),
        Color(0x665C9BC8),
        Color(0x809DD9F5),
        Color(0x4D5C9BC8),
      ],
      stops: [0, 0.38, 0.68, 1],
    ).createShader(rect);

    for (final filament in _filaments) {
      canvas.drawPath(
        filament.pathFor(size),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = filament.level == 2 ? 0.55 : 0.38
          ..strokeCap = StrokeCap.round
          ..color = EftVisualIdentity.circuit.withValues(
            alpha: filament.level == 2 ? 0.22 : 0.14,
          ),
      );
    }

    for (final branch in _branches) {
      final path = branch.pathFor(size);
      final lineWidth = switch (branch.level) {
        0 => 1.35,
        1 => 0.95,
        _ => 0.65,
      };
      final alpha = switch (branch.level) {
        0 => 0.42,
        1 => 0.3,
        _ => 0.2,
      };

      if (branch.level == 0) {
        canvas.drawPath(
          path,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 4
            ..strokeCap = StrokeCap.round
            ..color = EftVisualIdentity.circuit.withValues(alpha: 0.035),
        );
      }

      canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = lineWidth
          ..strokeCap = StrokeCap.round
          ..shader = branchShader
          ..color = Colors.white.withValues(alpha: alpha),
      );

      if (branch.level == 0) {
        _drawEnergyFlow(canvas, path, branch.flowOffset);
      }
    }

    for (final synapse in _synapses) {
      final point = _scale(synapse.point, size);
      final radius = 3.2 + (synapse.strength * 1.4);
      canvas.drawCircle(
        point,
        radius + 5,
        Paint()
          ..color = EftVisualIdentity.circuit.withValues(
            alpha: 0.025 + (synapse.strength * 0.035),
          ),
      );
      canvas.drawCircle(
        point,
        radius,
        Paint()
          ..color = EftVisualIdentity.circuit.withValues(
            alpha: 0.2 + (synapse.strength * 0.14),
          ),
      );
      canvas.drawCircle(
        point,
        1.4 + (synapse.strength * 0.7),
        Paint()
          ..color = EftVisualIdentity.circuitCore.withValues(
            alpha: 0.74 + (synapse.strength * 0.2),
          ),
      );
      canvas.drawCircle(
        point.translate(-0.55, -0.65),
        0.65,
        Paint()..color = Colors.white.withValues(alpha: 0.52),
      );
    }

    for (var index = 4; index < _filaments.length; index += 7) {
      final point = _scale(_filaments[index].end, size);
      canvas.drawCircle(
        point,
        3.2,
        Paint()..color = EftVisualIdentity.circuit.withValues(alpha: 0.055),
      );
      canvas.drawCircle(
        point,
        1.05,
        Paint()..color = EftVisualIdentity.circuitCore.withValues(alpha: 0.56),
      );
    }
  }

  void _drawEnergyFlow(Canvas canvas, Path path, double offset) {
    for (final metric in path.computeMetrics()) {
      final progress = (phase + offset) % 1;
      final head = metric.length * progress;
      final tail = math.max(0.0, head - 18);
      final flow = metric.extractPath(tail, head);
      canvas.drawPath(
        flow,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.8
          ..strokeCap = StrokeCap.round
          ..color = EftVisualIdentity.circuitCore.withValues(alpha: 0.3),
      );

      final tangent = metric.getTangentForOffset(head);
      if (tangent != null) {
        canvas.drawCircle(
          tangent.position,
          2.1,
          Paint()
            ..color = EftVisualIdentity.circuitCore.withValues(alpha: 0.38),
        );
      }
    }
  }

  Offset _scale(Offset point, Size size) =>
      Offset(point.dx * size.width, point.dy * size.height);

  @override
  bool shouldRepaint(covariant _EftLivingNetworkPainter oldDelegate) =>
      oldDelegate.phase != phase;
}

class _EftBranch {
  const _EftBranch(
    this.start,
    this.controlA,
    this.controlB,
    this.end, {
    this.level = 0,
    this.flowOffset = 0,
  });

  final Offset start;
  final Offset controlA;
  final Offset controlB;
  final Offset end;
  final int level;
  final double flowOffset;

  Path pathFor(Size size) => Path()
    ..moveTo(start.dx * size.width, start.dy * size.height)
    ..cubicTo(
      controlA.dx * size.width,
      controlA.dy * size.height,
      controlB.dx * size.width,
      controlB.dy * size.height,
      end.dx * size.width,
      end.dy * size.height,
    );
}

class _EftSynapse {
  const _EftSynapse(this.point, this.strength);

  final Offset point;
  final double strength;
}

List<_EftBranch> _buildEftFilaments() {
  final random = math.Random(7319);
  final filaments = <_EftBranch>[];
  const seeds = <(Offset, double, double)>[
    (Offset(0.06, 0.42), -2.72, 0.095),
    (Offset(0.11, 0.63), 2.18, 0.105),
    (Offset(0.28, 0.76), 1.86, 0.085),
    (Offset(0.34, 0.18), -2.55, 0.09),
    (Offset(0.31, 0.07), -2.18, 0.08),
    (Offset(0.61, 0.10), -1.03, 0.08),
    (Offset(0.72, 0.08), -0.46, 0.09),
    (Offset(0.94, 0.37), 0.34, 0.085),
    (Offset(0.96, 0.28), -0.42, 0.085),
    (Offset(0.67, 0.76), 1.34, 0.085),
    (Offset(0.70, 0.87), 0.74, 0.1),
    (Offset(0.97, 0.58), 0.64, 0.09),
  ];

  for (final seed in seeds) {
    _growEftFilament(
      filaments,
      random,
      start: seed.$1,
      direction: seed.$2,
      length: seed.$3,
      generations: 3,
      level: 2,
    );
  }
  return List.unmodifiable(filaments);
}

void _growEftFilament(
  List<_EftBranch> branches,
  math.Random random, {
  required Offset start,
  required double direction,
  required double length,
  required int generations,
  required int level,
}) {
  final directionVector = Offset(math.cos(direction), math.sin(direction));
  final normal = Offset(-directionVector.dy, directionVector.dx);
  final bend = (random.nextDouble() - 0.5) * length * 0.72;
  final end = start + (directionVector * length);
  final controlA = start + (directionVector * length * 0.32) + (normal * bend);
  final controlB =
      start +
      (directionVector * length * 0.7) -
      (normal * bend * (0.25 + (random.nextDouble() * 0.3)));

  branches.add(_EftBranch(start, controlA, controlB, end, level: level));

  if (generations == 0) return;

  final spread = 0.34 + (random.nextDouble() * 0.26);
  final nextLength = length * (0.61 + (random.nextDouble() * 0.11));
  _growEftFilament(
    branches,
    random,
    start: end,
    direction: direction - spread + ((random.nextDouble() - 0.5) * 0.12),
    length: nextLength,
    generations: generations - 1,
    level: level + 1,
  );
  _growEftFilament(
    branches,
    random,
    start: end,
    direction: direction + spread + ((random.nextDouble() - 0.5) * 0.12),
    length: nextLength * (0.9 + (random.nextDouble() * 0.12)),
    generations: generations - 1,
    level: level + 1,
  );
}
