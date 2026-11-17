import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import '../models/profile.dart';

class HeroSection extends StatelessComponent {
  final Profile profile;

  const HeroSection({required this.profile, super.key});

  @override
  Component build(BuildContext context) {
    // If heroPhoto is provided, use it; otherwise use the high-res developer portrait placeholder
    final photoUrl = profile.heroPhoto.isNotEmpty
        ? profile.heroPhoto
        : 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=900&auto=format&fit=crop&q=80';

    return section(
      classes:
          'relative min-h-[92vh] flex items-center justify-center px-6 pt-24 pb-16 bg-transparent overflow-hidden',
      [
        div(classes: 'max-w-7xl mx-auto w-full relative z-10', [
          div(
            classes:
                'grid grid-cols-1 lg:grid-cols-12 gap-12 lg:gap-8 items-center',
            [
              // Left Column: Intro & Bio
              div(classes: 'lg:col-span-7 space-y-7', [
                div(classes: 'space-y-3', [
                  // "Hello, I'm" Gradient Heading (Matching Supun Sathsara reference)
                  h2(
                    classes:
                        'text-4xl sm:text-6xl font-extrabold tracking-tight bg-gradient-to-r from-[#AB4AFF] via-[#C084FC] to-[#38BDF8] bg-clip-text text-transparent',
                    [text("Hello, I'm")],
                  ),
                  // Name in large bold white
                  h1(
                    classes:
                        'text-5xl sm:text-7xl font-extrabold text-white tracking-tight leading-none',
                    [text(profile.name)],
                  ),
                  // Subtitle / Specialization
                  h3(
                    classes:
                        'text-xl sm:text-2xl font-bold text-white pt-1 tracking-tight',
                    [text(profile.tagline)],
                  ),
                ]),

                // Bio Paragraph
                p(
                  classes:
                      'text-base sm:text-lg text-[#A1A1AA] max-w-xl leading-relaxed',
                  [
                    text(
                      'A Developer based in ${profile.location.isNotEmpty ? profile.location : "Sri Lanka"}, specializing in building exceptional mobile applications, Flutter architectures, and everything in between.',
                    ),
                  ],
                ),

                // Pill Action Buttons (Matching Screenshot)
                div(classes: 'flex flex-wrap items-center gap-4 pt-2', [
                  // "Hire Me" Pill Button
                  a(
                    href: '/#contact',
                    classes:
                        'inline-flex items-center justify-center px-8 py-3.5 rounded-full font-bold text-sm text-white bg-gradient-to-r from-[#AB4AFF] to-[#8B1FFF] hover:from-[#9732f0] hover:to-[#7812e5] transition-all duration-300 shadow-xl shadow-[#AB4AFF]/30 hover:shadow-2xl hover:shadow-[#AB4AFF]/50 hover:scale-105',
                    [text('Hire Me')],
                  ),

                  // "Download CV" / "Explore Work" Pill Button with Glowing Border
                  a(
                    href: profile.cvUrl.isNotEmpty ? profile.cvUrl : '/#projects',
                    target: profile.cvUrl.isNotEmpty ? Target.blank : Target.self,
                    classes:
                        'inline-flex items-center justify-center px-8 py-3.5 rounded-full font-bold text-sm text-white bg-[#0A0A0E]/80 border-2 border-[#38BDF8]/60 hover:border-[#38BDF8] hover:bg-[#38BDF8]/15 hover:shadow-lg hover:shadow-[#38BDF8]/25 transition-all duration-300 hover:scale-105',
                    [
                      text(profile.cvUrl.isNotEmpty
                          ? 'Download CV'
                          : 'Download CV'),
                    ],
                  ),
                ]),

                // Stats row
                div(
                  classes:
                      'grid grid-cols-3 gap-6 pt-6 border-t border-white/10 max-w-lg',
                  [
                    for (var stat in profile.stats)
                      div(classes: 'space-y-1', [
                        div(
                          classes:
                              'text-2xl sm:text-3xl font-extrabold text-[#AB4AFF]',
                          [text(stat.value)],
                        ),
                        div(
                          classes: 'text-xs font-medium text-[#A1A1AA]',
                          [text(stat.label)],
                        ),
                      ]),
                  ],
                ),
              ]),

              // Right Column: Big Circular Profile Image with Purple Glow Halo (Matching Reference)
              div(
                classes:
                    'lg:col-span-5 flex justify-center lg:justify-end relative',
                [
                  // Ambient Purple Glow behind the circle
                  div(
                    classes:
                        'absolute -inset-10 bg-gradient-to-tr from-[#AB4AFF]/40 via-[#7C3AED]/30 to-[#38BDF8]/20 rounded-full blur-3xl opacity-75 -z-10 animate-pulse',
                    [],
                  ),

                  // The Big Circular Image Container
                  div(
                    classes:
                        'relative w-72 h-72 sm:w-88 sm:h-88 lg:w-[410px] lg:h-[410px] rounded-full p-2 bg-gradient-to-b from-[#AB4AFF]/70 via-[#6366F1]/40 to-[#0A0A0E] circular-photo-glow shadow-2xl transition-transform duration-500 hover:scale-[1.02] group',
                    [
                      // Inner circle with image
                      div(
                        classes:
                            'w-full h-full rounded-full overflow-hidden bg-[#0F0F14] relative',
                        [
                          img(
                            src: photoUrl,
                            alt: profile.name,
                            classes:
                                'w-full h-full object-cover object-top filter brightness-[0.98] contrast-[1.05] group-hover:scale-105 transition-transform duration-700',
                          ),

                          // Subtle placeholder tag if photo not yet uploaded
                          if (profile.heroPhoto.isEmpty)
                            div(
                              classes:
                                  'absolute bottom-6 left-1/2 -translate-x-1/2 px-3 py-1 rounded-full bg-black/80 backdrop-blur-md border border-white/15 text-[11px] font-medium text-white/90 shadow-lg whitespace-nowrap',
                              [text('📷 Placeholder Photo')],
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
