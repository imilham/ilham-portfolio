import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class AmbientBackground extends StatelessComponent {
  const AmbientBackground({super.key});

  @override
  Component build(BuildContext context) {
    // Rich, high-density deterministic starfield across the entire galaxy canvas
    const stars = [
      // Top Region (0% - 25%)
      (top: 3, left: 8, size: 2.0, type: 'star-fast', color: 'bg-white'),
      (top: 5, left: 24, size: 2.8, type: 'star-sparkle', color: 'bg-white'),
      (top: 2, left: 42, size: 1.8, type: 'star-slow', color: 'bg-[#E0E7FF]'),
      (top: 7, left: 58, size: 3.2, type: 'star-pulse', color: 'bg-[#DDD6FE]'),
      (top: 4, left: 74, size: 2.2, type: 'star-fast', color: 'bg-white'),
      (top: 6, left: 88, size: 2.6, type: 'star-sparkle', color: 'bg-[#BAE6FD]'),
      (top: 9, left: 16, size: 2.5, type: 'star-pulse', color: 'bg-white'),
      (top: 11, left: 33, size: 1.8, type: 'star-slow', color: 'bg-[#F3E8FF]'),
      (top: 8, left: 50, size: 3.5, type: 'star-sparkle', color: 'bg-white'),
      (top: 13, left: 66, size: 2.0, type: 'star-fast', color: 'bg-white'),
      (top: 10, left: 82, size: 2.8, type: 'star-pulse', color: 'bg-[#DDD6FE]'),
      (top: 12, left: 95, size: 1.6, type: 'star-slow', color: 'bg-white'),
      (top: 16, left: 5, size: 2.2, type: 'star-fast', color: 'bg-[#BAE6FD]'),
      (top: 18, left: 21, size: 3.0, type: 'star-sparkle', color: 'bg-white'),
      (top: 15, left: 39, size: 2.0, type: 'star-slow', color: 'bg-white'),
      (top: 20, left: 55, size: 2.6, type: 'star-fast', color: 'bg-[#E0E7FF]'),
      (top: 17, left: 72, size: 3.4, type: 'star-pulse', color: 'bg-white'),
      (top: 22, left: 86, size: 2.2, type: 'star-slow', color: 'bg-[#F3E8FF]'),
      (top: 19, left: 98, size: 1.8, type: 'star-fast', color: 'bg-white'),
      (top: 24, left: 12, size: 2.5, type: 'star-pulse', color: 'bg-white'),

      // Upper Mid Region (25% - 50%)
      (top: 27, left: 28, size: 2.0, type: 'star-slow', color: 'bg-[#E0E7FF]'),
      (top: 29, left: 45, size: 3.2, type: 'star-sparkle', color: 'bg-white'),
      (top: 26, left: 63, size: 2.4, type: 'star-fast', color: 'bg-[#DDD6FE]'),
      (top: 31, left: 79, size: 2.8, type: 'star-pulse', color: 'bg-white'),
      (top: 28, left: 92, size: 2.0, type: 'star-slow', color: 'bg-[#BAE6FD]'),
      (top: 33, left: 7, size: 2.5, type: 'star-fast', color: 'bg-white'),
      (top: 36, left: 19, size: 3.6, type: 'star-sparkle', color: 'bg-white'),
      (top: 34, left: 35, size: 1.8, type: 'star-slow', color: 'bg-[#F3E8FF]'),
      (top: 38, left: 52, size: 2.8, type: 'star-pulse', color: 'bg-white'),
      (top: 35, left: 69, size: 2.2, type: 'star-fast', color: 'bg-white'),
      (top: 40, left: 84, size: 3.0, type: 'star-sparkle', color: 'bg-[#BAE6FD]'),
      (top: 37, left: 96, size: 1.8, type: 'star-slow', color: 'bg-[#DDD6FE]'),
      (top: 42, left: 14, size: 2.4, type: 'star-fast', color: 'bg-white'),
      (top: 45, left: 30, size: 3.2, type: 'star-pulse', color: 'bg-white'),
      (top: 43, left: 47, size: 1.8, type: 'star-slow', color: 'bg-[#E0E7FF]'),
      (top: 47, left: 61, size: 2.6, type: 'star-fast', color: 'bg-white'),
      (top: 44, left: 76, size: 3.5, type: 'star-sparkle', color: 'bg-white'),
      (top: 48, left: 90, size: 2.0, type: 'star-slow', color: 'bg-[#F3E8FF]'),

      // Lower Mid Region (50% - 75%)
      (top: 52, left: 4, size: 2.2, type: 'star-fast', color: 'bg-white'),
      (top: 54, left: 22, size: 3.0, type: 'star-sparkle', color: 'bg-[#BAE6FD]'),
      (top: 51, left: 38, size: 1.8, type: 'star-slow', color: 'bg-white'),
      (top: 56, left: 54, size: 2.8, type: 'star-pulse', color: 'bg-white'),
      (top: 53, left: 68, size: 2.2, type: 'star-fast', color: 'bg-[#DDD6FE]'),
      (top: 58, left: 83, size: 3.2, type: 'star-sparkle', color: 'bg-white'),
      (top: 55, left: 97, size: 1.8, type: 'star-slow', color: 'bg-white'),
      (top: 61, left: 11, size: 2.6, type: 'star-pulse', color: 'bg-white'),
      (top: 63, left: 27, size: 2.0, type: 'star-fast', color: 'bg-[#E0E7FF]'),
      (top: 60, left: 44, size: 3.4, type: 'star-sparkle', color: 'bg-white'),
      (top: 65, left: 59, size: 1.8, type: 'star-slow', color: 'bg-[#F3E8FF]'),
      (top: 62, left: 75, size: 2.8, type: 'star-pulse', color: 'bg-white'),
      (top: 67, left: 89, size: 2.2, type: 'star-fast', color: 'bg-white'),
      (top: 69, left: 6, size: 3.0, type: 'star-sparkle', color: 'bg-[#BAE6FD]'),
      (top: 72, left: 18, size: 2.0, type: 'star-slow', color: 'bg-white'),
      (top: 70, left: 34, size: 2.8, type: 'star-fast', color: 'bg-[#DDD6FE]'),
      (top: 74, left: 50, size: 3.6, type: 'star-pulse', color: 'bg-white'),
      (top: 71, left: 65, size: 2.2, type: 'star-slow', color: 'bg-white'),
      (top: 75, left: 80, size: 2.6, type: 'star-fast', color: 'bg-[#E0E7FF]'),
      (top: 73, left: 94, size: 3.2, type: 'star-sparkle', color: 'bg-white'),

      // Bottom Region (75% - 98%)
      (top: 78, left: 13, size: 2.2, type: 'star-pulse', color: 'bg-white'),
      (top: 81, left: 26, size: 3.0, type: 'star-sparkle', color: 'bg-white'),
      (top: 79, left: 41, size: 1.8, type: 'star-slow', color: 'bg-[#F3E8FF]'),
      (top: 84, left: 57, size: 2.6, type: 'star-fast', color: 'bg-[#DDD6FE]'),
      (top: 82, left: 71, size: 3.4, type: 'star-pulse', color: 'bg-white'),
      (top: 86, left: 86, size: 2.0, type: 'star-slow', color: 'bg-white'),
      (top: 83, left: 98, size: 2.4, type: 'star-fast', color: 'bg-[#BAE6FD]'),
      (top: 89, left: 8, size: 2.8, type: 'star-sparkle', color: 'bg-white'),
      (top: 92, left: 22, size: 1.8, type: 'star-slow', color: 'bg-white'),
      (top: 88, left: 37, size: 2.5, type: 'star-fast', color: 'bg-[#E0E7FF]'),
      (top: 93, left: 53, size: 3.2, type: 'star-pulse', color: 'bg-white'),
      (top: 90, left: 67, size: 2.0, type: 'star-slow', color: 'bg-[#F3E8FF]'),
      (top: 95, left: 81, size: 2.8, type: 'star-sparkle', color: 'bg-white'),
      (top: 91, left: 93, size: 2.2, type: 'star-fast', color: 'bg-white'),
      (top: 97, left: 15, size: 2.0, type: 'star-slow', color: 'bg-white'),
      (top: 96, left: 45, size: 3.0, type: 'star-sparkle', color: 'bg-[#BAE6FD]'),
      (top: 98, left: 73, size: 2.2, type: 'star-fast', color: 'bg-white'),

      // Extra Hero & Portrait Ambient Clusters (Right column around avatar)
      (top: 14, left: 68, size: 3.2, type: 'star-sparkle', color: 'bg-white'),
      (top: 21, left: 64, size: 2.4, type: 'star-pulse', color: 'bg-[#DDD6FE]'),
      (top: 25, left: 95, size: 3.0, type: 'star-fast', color: 'bg-white'),
      (top: 32, left: 66, size: 2.6, type: 'star-sparkle', color: 'bg-white'),
      (top: 39, left: 98, size: 3.4, type: 'star-pulse', color: 'bg-[#BAE6FD]'),
      (top: 49, left: 63, size: 2.2, type: 'star-fast', color: 'bg-white'),
      (top: 57, left: 93, size: 3.0, type: 'star-sparkle', color: 'bg-white'),
      (top: 64, left: 67, size: 2.8, type: 'star-pulse', color: 'bg-[#F3E8FF]'),
    ];

    // Floating cosmic stardust motes (ambient rising particles)
    const dustMotes = [
      (bottom: 10, left: 15, size: 2.5, type: 'dust-mote-1', color: 'bg-white/80'),
      (bottom: 22, left: 38, size: 2.2, type: 'dust-mote-2', color: 'bg-[#C084FC]/85'),
      (bottom: 8, left: 62, size: 2.4, type: 'dust-mote-3', color: 'bg-[#38BDF8]/80'),
      (bottom: 28, left: 78, size: 2.0, type: 'dust-mote-1', color: 'bg-white/90'),
      (bottom: 16, left: 86, size: 2.6, type: 'dust-mote-2', color: 'bg-[#E9D5FF]/85'),
      (bottom: 5, left: 28, size: 2.0, type: 'dust-mote-3', color: 'bg-white/70'),
      (bottom: 35, left: 52, size: 2.2, type: 'dust-mote-1', color: 'bg-[#BAE6FD]/80'),
      (bottom: 18, left: 94, size: 2.4, type: 'dust-mote-2', color: 'bg-white/85'),
    ];

    return div(
      classes:
          'fixed inset-0 pointer-events-none overflow-hidden z-0 select-none bg-deep-space',
      [
        // Cosmic Violet Nebula Cloud (Very subtle, deep space glow)
        div(
          classes:
              'absolute top-10 -right-20 w-[550px] h-[550px] rounded-full bg-gradient-to-bl from-[#AB4AFF]/08 via-[#7C3AED]/04 to-transparent blur-[140px] animate-nebula pointer-events-none',
          [],
        ),

        // Distant Indigo Nebula (Left side, very faint)
        div(
          classes:
              'absolute top-1/2 -left-32 w-[500px] h-[500px] rounded-full bg-gradient-to-tr from-[#6366F1]/06 via-[#4F46E5]/03 to-transparent blur-[140px] animate-nebula-alt pointer-events-none',
          [],
        ),

        // Shooting Stars (Meteors flying across the space background)
        div(
          classes:
              'absolute top-[12%] right-[6%] w-[240px] h-[2.2px] rounded-full shooting-star-1 opacity-0 pointer-events-none',
          [],
        ),
        div(
          classes:
              'absolute top-[35%] right-[26%] w-[260px] h-[2.4px] rounded-full shooting-star-2 opacity-0 pointer-events-none',
          [],
        ),
        div(
          classes:
              'absolute top-[58%] right-[12%] w-[220px] h-[2.0px] rounded-full shooting-star-3 opacity-0 pointer-events-none',
          [],
        ),
        div(
          classes:
              'absolute top-[78%] right-[32%] w-[250px] h-[2.2px] rounded-full shooting-star-1 opacity-0 pointer-events-none',
          [],
        ),

        // Floating Stardust Motes
        for (var mote in dustMotes)
          div(
            classes:
                'absolute rounded-full blur-[0.4px] ${mote.color} ${mote.type}',
            attributes: {
              'style':
                  'bottom: ${mote.bottom}%; left: ${mote.left}%; width: ${mote.size}px; height: ${mote.size}px;',
            },
            [],
          ),

        // High-Density Starfield elements
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
