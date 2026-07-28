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
  bool _reduceMotion = false;
  bool _continuing = false;
  bool _profileBackgroundPrecacheScheduled = false;

  @override
  void initState() {
    super.initState();
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_profileBackgroundPrecacheScheduled) {
      _profileBackgroundPrecacheScheduled = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        precacheImage(
          const AssetImage(EftVisualIdentity.profileBackgroundAsset),
          context,
        );
      });
    }

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
    } else {
      _introController.forward();
    }
  }

  @override
  void dispose() {
    _introController.dispose();
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
    final landscape = mediaQuery.orientation == Orientation.landscape;

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
            if (landscape)
              Image(
                key: const ValueKey('eft_landing_landscape_side_fill'),
                image: const AssetImage(
                  EftVisualIdentity.landingBackgroundAsset,
                ),
                fit: BoxFit.cover,
                alignment: const Alignment(0, -0.65),
                filterQuality: FilterQuality.high,
                color: const Color(0xB80A0D1A),
                colorBlendMode: BlendMode.srcATop,
                excludeFromSemantics: true,
              ),
            Image(
              key: const ValueKey('eft_landing_background_image'),
              image: const AssetImage(EftVisualIdentity.landingBackgroundAsset),
              fit: landscape ? BoxFit.contain : BoxFit.cover,
              alignment: Alignment.center,
              filterQuality: FilterQuality.high,
              excludeFromSemantics: true,
            ),
            DecoratedBox(
              key: const ValueKey('eft_landing_readability_scrim'),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    const Color(0xFF090B16).withValues(alpha: 0.08),
                    const Color(0xFF090B16).withValues(alpha: 0.34),
                  ],
                  stops: const [0, 0.68, 1],
                ),
              ),
            ),
            SafeArea(
              child: Semantics(
                key: const ValueKey('eft_landing_continue'),
                button: true,
                label: 'EFT. Tocar para continuar para a seleção de perfil',
                excludeSemantics: true,
                onTap: _continue,
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
                            const Spacer(),
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
          color: const Color(0xB31B1826),
          border: Border.all(color: EftVisualIdentity.border),
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color(0x4D000000),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
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
