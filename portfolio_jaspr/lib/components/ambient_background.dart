import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class AmbientBackground extends StatelessComponent {
  const AmbientBackground({super.key});

  @override
  Component build(BuildContext context) {
    return div(
      classes:
          'fixed inset-0 pointer-events-none overflow-hidden z-0 select-none',
      [
        // 1. Subtle, Clean Blueprint Grid
        div(classes: 'absolute inset-0 bg-tech-grid opacity-80', []),

        // 2. Gentle Dot Matrix overlay
        div(
          classes:
              'absolute top-0 left-0 right-0 h-[700px] bg-tech-dots opacity-70',
          [],
        ),

        // 3. Balanced, Ambient Aurora Glow Orbs (Soft 20-22% opacity, 115px blur)
        // Violet/Purple Orb (Top-Left)
        div(
          classes:
              'absolute -top-32 -left-24 w-[620px] h-[620px] rounded-full bg-[#AB4AFF]/22 blur-[115px] animate-orb-purple',
          [],
        ),

        // Electric Indigo Orb (Top-Right)
        div(
          classes:
              'absolute top-20 -right-28 w-[560px] h-[560px] rounded-full bg-[#6366F1]/18 blur-[120px] animate-orb-indigo',
          [],
        ),

        // Cyber Purple/Cyan Orb (Mid-Lower Center)
        div(
          classes:
              'absolute top-[520px] left-1/4 w-[480px] h-[480px] rounded-full bg-[#8B5CF6]/16 blur-[110px] animate-orb-cyan',
          [],
        ),

        // Lower Ambient Glow
        div(
          classes:
              'absolute top-[1100px] right-12 w-[500px] h-[500px] rounded-full bg-[#AB4AFF]/14 blur-[120px] animate-orb-purple',
          [],
        ),

        // 4. Subtle, Tiny Light Specks (twinkling naturally without harsh glow)
        div(
          classes:
              'absolute top-48 left-[16%] w-1.5 h-1.5 rounded-full bg-[#E9D5FF] blur-[0.5px] animate-particle-1',
          [],
        ),
        div(
          classes:
              'absolute top-72 right-[20%] w-1.5 h-1.5 rounded-full bg-[#C7D2FE] blur-[0.5px] animate-particle-2',
          [],
        ),
        div(
          classes:
              'absolute top-[500px] left-[42%] w-1 h-1 rounded-full bg-white/70 animate-particle-3',
          [],
        ),
        div(
          classes:
              'absolute top-[720px] right-[15%] w-1.5 h-1.5 rounded-full bg-[#E9D5FF] blur-[0.5px] animate-particle-1',
          [],
        ),
      ],
    );
  }
}
