import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class AmbientBackground extends StatelessComponent {
  const AmbientBackground({super.key});

  @override
  Component build(BuildContext context) {
    // Deterministic star field coordinates (percentages) across the cosmos
    const stars = [
      (top: 8, left: 12, size: 1.0, type: 'star-slow', color: 'bg-white/80'),
      (top: 14, left: 28, size: 1.5, type: 'star-fast', color: 'bg-white'),
      (top: 6, left: 45, size: 1.0, type: 'star-slow', color: 'bg-white/70'),
      (top: 18, left: 62, size: 2.0, type: 'star-pulse', color: 'bg-[#E9D5FF]'),
      (top: 10, left: 82, size: 1.2, type: 'star-fast', color: 'bg-white'),
      (top: 24, left: 8, size: 1.5, type: 'star-fast', color: 'bg-[#C7D2FE]'),
      (top: 32, left: 22, size: 1.0, type: 'star-slow', color: 'bg-white/60'),
      (top: 28, left: 38, size: 2.2, type: 'star-pulse', color: 'bg-white'),
      (top: 36, left: 54, size: 1.2, type: 'star-fast', color: 'bg-white/90'),
      (top: 22, left: 74, size: 1.0, type: 'star-slow', color: 'bg-white/70'),
      (top: 30, left: 92, size: 1.5, type: 'star-fast', color: 'bg-[#E9D5FF]'),
      (top: 42, left: 15, size: 2.0, type: 'star-pulse', color: 'bg-white'),
      (top: 48, left: 32, size: 1.0, type: 'star-slow', color: 'bg-white/70'),
      (top: 44, left: 48, size: 1.4, type: 'star-fast', color: 'bg-[#C7D2FE]'),
      (top: 52, left: 68, size: 1.8, type: 'star-pulse', color: 'bg-white'),
      (top: 40, left: 85, size: 1.0, type: 'star-slow', color: 'bg-white/60'),
      (top: 58, left: 6, size: 1.2, type: 'star-fast', color: 'bg-white/80'),
      (top: 64, left: 25, size: 1.0, type: 'star-slow', color: 'bg-white/70'),
      (top: 60, left: 42, size: 2.4, type: 'star-pulse', color: 'bg-[#F3E8FF]'),
      (top: 68, left: 58, size: 1.0, type: 'star-slow', color: 'bg-white/60'),
      (top: 56, left: 78, size: 1.5, type: 'star-fast', color: 'bg-white'),
      (top: 66, left: 94, size: 1.0, type: 'star-slow', color: 'bg-white/70'),
      (top: 76, left: 18, size: 1.6, type: 'star-fast', color: 'bg-[#E0E7FF]'),
      (top: 82, left: 36, size: 1.0, type: 'star-slow', color: 'bg-white/70'),
      (top: 74, left: 52, size: 2.0, type: 'star-pulse', color: 'bg-white'),
      (top: 88, left: 70, size: 1.2, type: 'star-fast', color: 'bg-white/90'),
      (top: 80, left: 88, size: 1.0, type: 'star-slow', color: 'bg-white/60'),
      (top: 92, left: 10, size: 1.5, type: 'star-fast', color: 'bg-white'),
      (top: 94, left: 45, size: 1.0, type: 'star-slow', color: 'bg-white/70'),
      (top: 90, left: 82, size: 1.8, type: 'star-pulse', color: 'bg-[#E9D5FF]'),
      // Clusters around right side & hero
      (top: 16, left: 70, size: 2.2, type: 'star-pulse', color: 'bg-white'),
      (top: 26, left: 65, size: 1.2, type: 'star-fast', color: 'bg-[#D8B4FE]'),
      (top: 38, left: 72, size: 1.0, type: 'star-slow', color: 'bg-white/80'),
      (top: 12, left: 90, size: 2.0, type: 'star-pulse', color: 'bg-white'),
      (top: 46, left: 96, size: 1.4, type: 'star-fast', color: 'bg-white/90'),
      (top: 5, left: 20, size: 1.8, type: 'star-pulse', color: 'bg-[#E0E7FF]'),
      (top: 20, left: 4, size: 1.0, type: 'star-slow', color: 'bg-white/60'),
      (top: 72, left: 82, size: 1.6, type: 'star-fast', color: 'bg-white'),
    ];

    // Floating cosmic stardust motes (ambient rising particles)
    const dustMotes = [
      (bottom: 12, left: 18, size: 2.2, type: 'dust-mote-1', color: 'bg-white/60'),
      (bottom: 25, left: 42, size: 1.8, type: 'dust-mote-2', color: 'bg-[#C084FC]/70'),
      (bottom: 8, left: 65, size: 2.0, type: 'dust-mote-3', color: 'bg-[#38BDF8]/60'),
      (bottom: 30, left: 82, size: 1.6, type: 'dust-mote-1', color: 'bg-white/70'),
      (bottom: 18, left: 88, size: 2.4, type: 'dust-mote-2', color: 'bg-[#E9D5FF]/65'),
      (bottom: 5, left: 32, size: 1.5, type: 'dust-mote-3', color: 'bg-white/50'),
    ];

    return div(
      classes:
          'fixed inset-0 pointer-events-none overflow-hidden z-0 select-none bg-deep-space',
      [
        // Cosmic Violet Nebula Cloud (Soft glowing space dust on the right side)
        div(
          classes:
              'absolute top-10 -right-20 w-[780px] h-[780px] rounded-full bg-gradient-to-bl from-[#AB4AFF]/22 via-[#7C3AED]/14 to-transparent blur-[120px] animate-nebula',
          [],
        ),

        // Distant Indigo Nebula (Left side)
        div(
          classes:
              'absolute top-1/2 -left-32 w-[680px] h-[680px] rounded-full bg-gradient-to-tr from-[#6366F1]/18 via-[#4F46E5]/12 to-transparent blur-[130px] animate-nebula-alt',
          [],
        ),

        // Shooting Stars (Meteors flying across the space background)
        div(
          classes:
              'absolute top-[14%] right-[8%] w-[220px] h-[2px] rounded-full shooting-star-1 opacity-0 pointer-events-none',
          [],
        ),
        div(
          classes:
              'absolute top-[38%] right-[28%] w-[240px] h-[2px] rounded-full shooting-star-2 opacity-0 pointer-events-none',
          [],
        ),
        div(
          classes:
              'absolute top-[62%] right-[14%] w-[200px] h-[1.8px] rounded-full shooting-star-3 opacity-0 pointer-events-none',
          [],
        ),

        // Floating Stardust Motes
        for (var mote in dustMotes)
          div(
            classes:
                'absolute rounded-full blur-[0.5px] ${mote.color} ${mote.type}',
            attributes: {
              'style':
                  'bottom: ${mote.bottom}%; left: ${mote.left}%; width: ${mote.size}px; height: ${mote.size}px;',
            },
            [],
          ),

        // Starfield elements
        for (var star in stars)
          div(
            classes:
                'absolute rounded-full ${star.color} ${star.type}',
            attributes: {
              'style':
                  'top: ${star.top}%; left: ${star.left}%; width: ${star.size}px; height: ${star.size}px;',
            },
            [],
          ),
      ],
    );
  }
}
