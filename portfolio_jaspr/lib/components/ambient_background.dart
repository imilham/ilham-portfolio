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
        // 1. Visible Blueprint Grid Pattern
        div(classes: 'absolute inset-0 bg-tech-grid opacity-90', []),

        // 2. Glowing Dot Matrix across top half
        div(
          classes:
              'absolute top-0 left-0 right-0 h-[850px] bg-tech-dots opacity-90',
          [],
        ),

        // 3. Top Glowing Neon Horizon Beam
        div(
          classes:
              'absolute top-0 left-1/2 -translate-x-1/2 w-4/5 h-[2px] bg-gradient-to-r from-transparent via-[#AB4AFF] to-transparent shadow-[0_0_30px_3px_#AB4AFF]',
          [],
        ),

        // 4. Vibrant Floating Ambient Aurora Orbs (Reduced blur & boosted opacity for high visibility)
        // Primary Neon Violet Orb (Top Left - Floating)
        div(
          classes:
              'absolute -top-24 -left-20 w-[680px] h-[680px] rounded-full bg-gradient-to-tr from-[#AB4AFF]/40 via-[#9333EA]/35 to-transparent blur-[85px] animate-orb-purple',
          [],
        ),

        // Electric Indigo/Blue Orb (Top Right - Floating)
        div(
          classes:
              'absolute top-28 -right-24 w-[620px] h-[620px] rounded-full bg-gradient-to-bl from-[#6366F1]/38 via-[#3B82F6]/30 to-transparent blur-[85px] animate-orb-indigo',
          [],
        ),

        // Cyber Cyan/Purple Orb (Center / Lower Page - Floating)
        div(
          classes:
              'absolute top-[550px] left-1/4 w-[580px] h-[580px] rounded-full bg-gradient-to-r from-[#06B6D4]/30 via-[#8B5CF6]/35 to-transparent blur-[80px] animate-orb-cyan',
          [],
        ),

        // Lower Purple Ambient Light for lower sections
        div(
          classes:
              'absolute top-[1200px] right-10 w-[550px] h-[550px] rounded-full bg-[#AB4AFF]/28 blur-[90px] animate-orb-purple',
          [],
        ),

        // 5. Vivid Twinkling Floating Particles
        div(
          classes:
              'absolute top-52 left-[18%] w-2.5 h-2.5 rounded-full bg-[#D8B4FE] glow-particle-purple animate-particle-1',
          [],
        ),
        div(
          classes:
              'absolute top-80 right-[22%] w-3 h-3 rounded-full bg-[#818CF8] glow-particle-indigo animate-particle-2',
          [],
        ),
        div(
          classes:
              'absolute top-[520px] left-[38%] w-2 h-2 rounded-full bg-[#22D3EE] glow-particle-cyan animate-particle-3',
          [],
        ),
        div(
          classes:
              'absolute top-[750px] right-[14%] w-3 h-3 rounded-full bg-[#C084FC] glow-particle-purple animate-particle-1',
          [],
        ),
        div(
          classes:
              'absolute top-[980px] left-[12%] w-2.5 h-2.5 rounded-full bg-[#818CF8] glow-particle-indigo animate-particle-2',
          [],
        ),
      ],
    );
  }
}
