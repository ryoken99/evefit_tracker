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
      _ambientController.repeat(reverse: true);
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
                key: const ValueKey('eft_landing_circuit'),
                animation: _ambientController,
                builder: (context, _) => CustomPaint(
                  painter: _EftCircuitPainter(phase: _ambientController.value),
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

class _EftCircuitPainter extends CustomPainter {
  const _EftCircuitPainter({required this.phase});

  final double phase;

  static const _points = <Offset>[
    Offset(0.06, 0.16),
    Offset(0.19, 0.12),
    Offset(0.31, 0.2),
    Offset(0.47, 0.12),
    Offset(0.67, 0.18),
    Offset(0.88, 0.1),
    Offset(0.1, 0.42),
    Offset(0.25, 0.5),
    Offset(0.46, 0.43),
    Offset(0.73, 0.49),
    Offset(0.92, 0.39),
    Offset(0.08, 0.73),
    Offset(0.29, 0.82),
    Offset(0.51, 0.7),
    Offset(0.72, 0.81),
    Offset(0.92, 0.69),
  ];

  static const _links = <(int, int)>[
    (0, 1),
    (1, 2),
    (2, 3),
    (3, 4),
    (4, 5),
    (0, 6),
    (2, 7),
    (3, 8),
    (4, 9),
    (5, 10),
    (6, 7),
    (7, 8),
    (8, 9),
    (9, 10),
    (6, 11),
    (7, 12),
    (8, 13),
    (9, 14),
    (10, 15),
    (11, 12),
    (12, 13),
    (13, 14),
    (14, 15),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.15
      ..shader = LinearGradient(
        colors: [
          EftVisualIdentity.circuit.withValues(alpha: 0.12),
          EftVisualIdentity.circuitCore.withValues(alpha: 0.2 + (phase * 0.08)),
          EftVisualIdentity.circuit.withValues(alpha: 0.1),
        ],
      ).createShader(rect);

    for (final link in _links) {
      final start = _scale(_points[link.$1], size);
      final end = _scale(_points[link.$2], size);
      final middleX = start.dx + ((end.dx - start.dx) * 0.52);
      final path = Path()
        ..moveTo(start.dx, start.dy)
        ..lineTo(middleX, start.dy)
        ..lineTo(middleX, end.dy)
        ..lineTo(end.dx, end.dy);
      canvas.drawPath(path, linePaint);
    }

    for (var index = 0; index < _points.length; index++) {
      final point = _scale(_points[index], size);
      final pulse = 0.5 + (0.5 * math.sin((phase + index / 7) * math.pi));
      canvas.drawCircle(
        point,
        8 + pulse,
        Paint()
          ..color = EftVisualIdentity.circuit.withValues(
            alpha: 0.035 + (pulse * 0.025),
          ),
      );
      canvas.drawCircle(
        point,
        5.2,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.3
          ..color = EftVisualIdentity.circuit.withValues(alpha: 0.48),
      );
      canvas.drawCircle(
        point,
        2.1,
        Paint()..color = EftVisualIdentity.circuitCore.withValues(alpha: 0.82),
      );
    }
  }

  Offset _scale(Offset point, Size size) =>
      Offset(point.dx * size.width, point.dy * size.height);

  @override
  bool shouldRepaint(covariant _EftCircuitPainter oldDelegate) =>
      oldDelegate.phase != phase;
}
