import 'dart:async';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class AnimatedRotatingTitle extends StatefulComponent {
  final List<String> titles;
  final String fallbackTagline;

  const AnimatedRotatingTitle({
    required this.titles,
    this.fallbackTagline = 'Senior Mobile Engineer & Flutter Specialist',
    super.key,
  });

  @override
  State<AnimatedRotatingTitle> createState() => _AnimatedRotatingTitleState();
}

class _AnimatedRotatingTitleState extends State<AnimatedRotatingTitle> {
  int _currentIndex = 0;
  bool _isExiting = false;
  Timer? _cycleTimer;
  Timer? _transitionTimer;

  List<String> get _activeTitles {
    final valid = component.titles.where((t) => t.trim().isNotEmpty).toList();
    if (valid.length >= 2) return valid;
    if (valid.length == 1) {
      final single = valid.first;
      if (single.contains('&')) {
        final split = single.split('&').map((item) => item.trim()).where((item) => item.isNotEmpty).toList();
        if (split.length >= 2) return split;
      }
    }
    return const [
      'Senior Mobile Engineer',
      'Flutter Specialist',
      'Entrepreneur',
    ];
  }

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _startAnimationCycle();
    }
  }

  @override
  void didUpdateComponent(AnimatedRotatingTitle oldComponent) {
    super.didUpdateComponent(oldComponent);
    final currentList = _activeTitles;
    if (_currentIndex >= currentList.length) {
      _currentIndex = 0;
    }
    // Restart animation cycle if it was idle or component refreshed
    if (kIsWeb && (_cycleTimer == null || !_cycleTimer!.isActive)) {
      _startAnimationCycle();
    }
  }

  void _startAnimationCycle() {
    _cycleTimer?.cancel();
    _transitionTimer?.cancel();

    final titlesList = _activeTitles;
    if (titlesList.length <= 1) return;

    final currentWord = titlesList[_currentIndex % titlesList.length];
    // Keep visible so user can comfortably read: staggered animation (~35ms per char) + 2600ms pause
    final displayDurationMs = (currentWord.length * 35) + 2600;

    _cycleTimer = Timer(Duration(milliseconds: displayDurationMs), () {
      if (!mounted) return;
      setState(() {
        _isExiting = true;
      });

      // Exit transition takes 300ms -> swap word and slide next word in
      _transitionTimer = Timer(const Duration(milliseconds: 320), () {
        if (!mounted) return;
        setState(() {
          _currentIndex = (_currentIndex + 1) % _activeTitles.length;
          _isExiting = false;
        });
        _startAnimationCycle();
      });
    });
  }

  @override
  void dispose() {
    _cycleTimer?.cancel();
    _transitionTimer?.cancel();
    super.dispose();
  }

  @override
  Component build(BuildContext context) {
    final titlesList = _activeTitles;
    final text = titlesList[_currentIndex % titlesList.length];

    return div(
      classes:
          'text-xl sm:text-2xl lg:text-3xl font-bold text-white pt-1 tracking-tight min-h-[2.25rem] sm:min-h-[2.75rem] flex items-center flex-wrap select-none',
      [
        span(
          key: Key('title-word-$_currentIndex-$_isExiting'),
          classes: 'inline-flex items-center flex-wrap',
          [
            for (int i = 0; i < text.length; i++)
              span(
                key: Key('char-$_currentIndex-$_isExiting-$i'),
                classes: _isExiting ? 'anim-letter-out' : 'anim-letter-in',
                attributes: {
                  'style': 'animation-delay: ${i * 35}ms;',
                },
                [
                  Component.text(text[i] == ' ' ? '\u00A0' : text[i]),
                ],
              ),
          ],
        ),
        // Pulsing Neon Purple/Cyan Cursor Bar
        span(classes: 'anim-cursor', []),
      ],
    );
  }
}
