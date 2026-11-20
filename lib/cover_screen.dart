import 'dart:math' as math;
import 'package:flutter/material.dart';

class CoverScreen extends StatefulWidget {
  final Widget next;
  const CoverScreen({super.key, required this.next});

  @override
  State<CoverScreen> createState() => _CoverScreenState();
}

class _CoverScreenState extends State<CoverScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );
  bool _busy = false;

  Future<void> _open() async {
    if (_busy) return;
    _busy = true;
    await _c.forward(); // cover swings open
    if (!mounted) return;
    // push the real menu instantly (it looks identical to what's underneath)
    await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: true,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        pageBuilder: (context, animation, secondaryAnimation) => widget.next,
      ),
    );
    if (!mounted) return;
    await _c.reverse(); // back button pressed: cover swings shut
    _busy = false;
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // the page revealed under the cover
        IgnorePointer(child: widget.next),
        // the cover
        AnimatedBuilder(
          animation: _c,
          builder: (context, _) {
            final t = Curves.easeInOutCubic.transform(_c.value);
            if (t >= 1) return const SizedBox.shrink();
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _open,
              child: Transform(
                alignment: Alignment.centerLeft, // the spine
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0012) // perspective
                  ..rotateY(-t * math.pi / 2),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/diary_cover_page.png',
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.none,
                    ),
                    // shading gets darker as the cover turns away
                    ColoredBox(
                      color: Colors.black.withValues(alpha: t * 0.35),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}