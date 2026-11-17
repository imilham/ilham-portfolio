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
        // Subtle Blueprint Grid Pattern
        div(classes: 'absolute inset-0 bg-tech-grid opacity-75', []),

        // Dot Matrix Accent over hero area
        div(classes: 'absolute top-0 left-0 right-0 h-[800px] bg-tech-dots opacity-80', []),

        // Ambient Floating Aurora Orbs (Smooth Hardware-Accelerated Transforms)
        // 1. Primary Violet/Purple Orb (Top-Left)
        div(
          classes:
              'absolute -top-32 -left-32 w-[620px] h-[620px] rounded-full bg-[#AB4AFF]/15 blur-[150px] animate-orb-purple',
          [],
        ),

        // 2. Electric Indigo Orb (Top-Right / Center)
        div(
          classes:
              'absolute top-1/4 -right-32 w-[580px] h-[580px] rounded-full bg-[#4F46E5]/12 blur-[160px] animate-orb-indigo',
          [],
        ),

        // 3. Deep Cyber Purple Orb (Lower-Center)
        div(
          classes:
              'absolute top-2/3 left-1/4 w-[500px] h-[500px] rounded-full bg-[#7C3AED]/12 blur-[140px] animate-orb-cyan',
          [],
        ),

        // Floating Soft Light Particles
        div(
          classes:
              'absolute top-48 left-[15%] w-1.5 h-1.5 rounded-full bg-[#AB4AFF] blur-[1px] animate-particle-1',
          [],
        ),
        div(
          classes:
              'absolute top-72 right-[20%] w-2 h-2 rounded-full bg-[#818CF8] blur-[1.5px] animate-particle-2',
          [],
        ),
        div(
          classes:
              'absolute top-[550px] left-[45%] w-1 h-1 rounded-full bg-white/70 blur-[0.5px] animate-particle-3',
          [],
        ),
        div(
          classes:
              'absolute top-[800px] right-[10%] w-2 h-2 rounded-full bg-[#C084FC]/80 blur-[1px] animate-particle-1',
          [],
        ),
      ],
    );
  }
}
