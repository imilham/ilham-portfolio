import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import '../models/profile.dart';

class HeroSection extends StatelessComponent {
  final Profile profile;

  const HeroSection({required this.profile, super.key});

  @override
  Component build(BuildContext context) {
    // Placeholder image URL if heroPhoto is not yet provided
    final photoUrl = profile.heroPhoto.isNotEmpty
        ? profile.heroPhoto
        : 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800&auto=format&fit=crop&q=80';

    return section(
      classes:
          'relative min-h-[92vh] flex items-center justify-center px-6 pt-28 pb-20 bg-transparent overflow-hidden',
      [
        // Subtle local hero spotlight
        div(
          classes:
              'absolute top-1/4 left-1/2 -translate-x-1/2 w-[700px] h-[400px] bg-gradient-to-tr from-[#AB4AFF]/20 via-[#6366F1]/15 to-transparent blur-[140px] pointer-events-none rounded-full',
          [],
        ),

        div(classes: 'max-w-7xl mx-auto w-full relative z-10', [
          div(
            classes:
                'grid grid-cols-1 lg:grid-cols-12 gap-12 lg:gap-16 items-center',
            [
              // Left Column (Text & Bio)
              div(classes: 'lg:col-span-7 space-y-8', [
                // Top Status Badge
                div(
                  classes:
                      'inline-flex items-center gap-2.5 px-4 py-2 rounded-full bg-[#121218]/90 border border-[#2A2A38] text-xs font-semibold text-[#C4C4CC] shadow-inner',
                  [
                    span(
                      classes:
                          'w-2.5 h-2.5 rounded-full bg-emerald-400 animate-pulse shadow-sm shadow-emerald-400',
                      [],
                    ),
                    text('Available for Senior & Lead Roles • Remote / Hybrid'),
                  ],
                ),

                // Main Heading with Gradient Accent
                div(classes: 'space-y-4', [
                  h1(
                    classes:
                        'text-4xl sm:text-6xl lg:text-7xl font-extrabold tracking-tight text-white leading-[1.1]',
                    [
                      text("Hi, I'm "),
                      span(
                        classes:
                            'bg-gradient-to-r from-[#AB4AFF] via-[#D8B4FE] to-[#818CF8] bg-clip-text text-transparent shimmer-gradient',
                        [text(profile.name)],
                      ),
                    ],
                  ),
                  p(
                    classes:
                        'text-xl sm:text-2xl font-bold text-[#E4E4E7] tracking-tight',
                    [text(profile.tagline)],
                  ),
                  p(
                    classes:
                        'text-base sm:text-lg text-[#8A8A93] max-w-2xl leading-relaxed',
                    [text(profile.bio)],
                  ),
                ]),

                // Action Buttons
                div(classes: 'flex flex-wrap items-center gap-4 pt-2', [
                  a(
                    href: '/#projects',
                    classes:
                        'inline-flex items-center justify-center gap-2 px-7 py-3.5 rounded-xl font-bold text-sm text-white bg-gradient-to-r from-[#AB4AFF] to-[#8B1FFF] hover:from-[#9732f0] hover:to-[#7812e5] transition-all duration-300 shadow-xl shadow-[#AB4AFF]/25 hover:shadow-2xl hover:shadow-[#AB4AFF]/40 hover:-translate-y-0.5',
                    [text('Explore My Work ↗')],
                  ),
                  a(
                    href: '/#contact',
                    classes:
                        'inline-flex items-center justify-center px-7 py-3.5 rounded-xl font-semibold text-sm text-[#F4F4F6] bg-[#121216] border border-[#2A2A38] hover:bg-[#1A1A24] hover:border-[#AB4AFF]/50 transition-all duration-200',
                    [text('Contact Me')],
                  ),
                  if (profile.cvUrl.isNotEmpty)
                    a(
                      href: profile.cvUrl,
                      target: Target.blank,
                      classes:
                          'inline-flex items-center justify-center px-5 py-3.5 rounded-xl font-medium text-xs text-[#8A8A93] hover:text-white transition-colors',
                      [text('Download CV ↓')],
                    ),
                ]),

                // Stats row
                div(
                  classes:
                      'grid grid-cols-3 gap-6 pt-8 border-t border-[#1A1A24] max-w-lg',
                  [
                    for (var stat in profile.stats)
                      div(classes: 'space-y-1', [
                        div(
                          classes:
                              'text-2xl sm:text-3xl font-extrabold text-white tracking-tight',
                          [text(stat.value)],
                        ),
                        div(
                          classes: 'text-xs font-medium text-[#8A8A93]',
                          [text(stat.label)],
                        ),
                      ]),
                  ],
                ),
              ]),

              // Right Column (Prominent Profile Photo & Badge Card)
              div(
                classes:
                    'lg:col-span-5 flex justify-center lg:justify-end relative',
                [
                  // Radial Glow Behind Photo Card
                  div(
                    classes:
                        'absolute -inset-6 bg-gradient-to-tr from-[#AB4AFF]/60 via-[#6366F1]/50 to-[#3B82F6]/40 rounded-[44px] blur-2xl opacity-85 -z-10',
                    [],
                  ),

                  // Main Card Frame with Animated Border Glow
                  div(
                    classes:
                        'relative w-full max-w-[340px] sm:max-w-[380px] rounded-[32px] p-2.5 bg-gradient-to-b from-[#2E2E3E]/70 via-[#1A1A24]/60 to-[#121218]/80 border border-[#AB4AFF]/30 shadow-2xl backdrop-blur-sm card-glow-pulse group',
                    [
                      // Inner Photo Container
                      div(
                        classes:
                            'relative w-full aspect-[4/5] rounded-[24px] overflow-hidden bg-[#121218]',
                        [
                          // Profile Image
                          img(
                            src: photoUrl,
                            alt: profile.name,
                            classes:
                                'w-full h-full object-cover object-top filter contrast-[1.05] brightness-[0.95] group-hover:scale-105 transition-transform duration-700',
                          ),

                          // Dark Gradient Overlay for contrast with floating badges
                          div(
                            classes:
                                'absolute inset-0 bg-gradient-to-t from-[#0A0A0C] via-transparent to-black/30 pointer-events-none',
                            [],
                          ),

                          // Top-Left Floating Badge
                          div(
                            classes:
                                'absolute top-4 left-4 inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-[#0A0A0C]/80 backdrop-blur-md border border-[#AB4AFF]/40 text-xs font-semibold text-white shadow-lg',
                            [
                              span(
                                classes: 'text-[#AB4AFF]',
                                [text('⚡')],
                              ),
                              text('Flutter & Dart Expert'),
                            ],
                          ),

                          // Top-Right Placeholder Indicator (if using placeholder)
                          if (profile.heroPhoto.isEmpty)
                            div(
                              classes:
                                  'absolute top-4 right-4 px-2.5 py-1 rounded-md bg-black/75 backdrop-blur-md border border-white/10 text-[10px] font-mono text-[#A1A1AA] uppercase tracking-wider',
                              [text('Placeholder')],
                            ),

                          // Bottom Card Details Overlay
                          div(
                            classes:
                                'absolute bottom-0 left-0 right-0 p-5 space-y-2',
                            [
                              div(classes: 'flex items-center justify-between', [
                                div(classes: 'space-y-0.5', [
                                  h3(
                                    classes:
                                        'text-lg font-bold text-white tracking-tight',
                                    [text(profile.name)],
                                  ),
                                  p(
                                    classes:
                                        'text-xs font-medium text-[#AB4AFF]',
                                    [text('Senior Mobile Engineer')],
                                  ),
                                ]),
                                span(
                                  classes:
                                      'inline-flex items-center px-2 py-1 rounded-full text-[11px] font-medium bg-emerald-500/20 text-emerald-400 border border-emerald-500/30',
                                  [text('Verified')],
                                ),
                              ]),

                              // Tech pills inside card
                              div(classes: 'flex flex-wrap gap-1.5 pt-1', [
                                for (var tech in [
                                  'Flutter',
                                  'Dart',
                                  'Clean Arch',
                                  'Jaspr',
                                ])
                                  span(
                                    classes:
                                        'px-2 py-0.5 rounded text-[10px] font-semibold bg-[#1A1A24]/90 text-[#D4D4D8] border border-[#2E2E40]',
                                    [text(tech)],
                                  ),
                              ]),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ]),
      ],
    );
  }
}
