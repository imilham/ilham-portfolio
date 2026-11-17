import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import '../models/profile.dart';

class HeroSection extends StatelessComponent {
  final Profile profile;

  const HeroSection({required this.profile, super.key});

  @override
  Component build(BuildContext context) {
    return section(
      classes:
          'min-h-[90vh] flex items-center justify-center px-6 pt-28 pb-16 bg-[#0A0A0C]',
      [
        div(classes: 'max-w-7xl mx-auto w-full', [
          div(
            classes:
                'grid grid-cols-1 lg:grid-cols-12 gap-12 items-center',
            [
              // Left Column
              div(classes: 'lg:col-span-7 space-y-8', [
                // Badge
                div(
                  classes:
                      'inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-[#1A1A22] border border-[#2A2A36] text-xs font-medium text-[#C4C4CC]',
                  [
                    span(
                      classes: 'w-2 h-2 rounded-full bg-emerald-400 animate-pulse',
                      [],
                    ),
                    text('Available for Full-time & Contract roles'),
                  ],
                ),

                // Main Heading
                div(classes: 'space-y-4', [
                  h1(
                    classes:
                        'text-4xl sm:text-6xl lg:text-7xl font-extrabold tracking-tight text-white leading-tight',
                    [
                      text("Hi, I'm "),
                      span(classes: 'text-[#AB4AFF]', [text(profile.name)]),
                    ],
                  ),
                  p(
                    classes:
                        'text-xl sm:text-2xl font-semibold text-[#C4C4CC]',
                    [text(profile.tagline)],
                  ),
                  p(
                    classes:
                        'text-base sm:text-lg text-[#8A8A93] max-w-2xl leading-relaxed',
                    [text(profile.bio)],
                  ),
                ]),

                // CTAs
                div(classes: 'flex flex-wrap gap-4 pt-2', [
                  a(
                    href: '/#projects',
                    classes:
                        'inline-flex items-center justify-center px-6 py-3.5 rounded-xl font-semibold text-white bg-[#AB4AFF] hover:bg-[#9732f0] transition-all shadow-lg shadow-[#AB4AFF]/25',
                    [text('Explore Projects →')],
                  ),
                  a(
                    href: '/#contact',
                    classes:
                        'inline-flex items-center justify-center px-6 py-3.5 rounded-xl font-semibold text-[#F4F4F6] bg-[#121216] border border-[#1A1A22] hover:bg-[#1A1A22] transition-colors',
                    [text('Contact Me')],
                  ),
                ]),

                // Stats row
                div(
                  classes:
                      'grid grid-cols-3 gap-6 pt-8 border-t border-[#1A1A22] max-w-lg',
                  [
                    for (var stat in profile.stats)
                      div(classes: 'space-y-1', [
                        div(
                          classes:
                              'text-2xl sm:text-3xl font-bold text-white',
                          [text(stat.value)],
                        ),
                        div(
                          classes: 'text-xs sm:text-sm text-[#8A8A93]',
                          [text(stat.label)],
                        ),
                      ]),
                  ],
                ),
              ]),

              // Right Column (Visual Card / Flutter Badge)
              div(
                classes:
                    'lg:col-span-5 flex justify-center lg:justify-end',
                [
                  div(
                    classes:
                        'relative w-full max-w-md p-8 rounded-3xl bg-gradient-to-br from-[#121216] to-[#1A1A22] border border-[#2A2A36] shadow-2xl space-y-6',
                    [
                      div(
                        classes:
                            'flex items-center justify-between pb-6 border-b border-[#2A2A36]',
                        [
                          div(classes: 'space-y-1', [
                            span(
                              classes:
                                  'text-xs font-semibold text-[#AB4AFF] uppercase tracking-wider',
                              [text('Core Specialization')],
                            ),
                            h3(classes: 'text-xl font-bold text-white', [
                              text('Flutter & Dart Expert'),
                            ]),
                          ]),
                          div(
                            classes:
                                'w-12 h-12 rounded-2xl bg-[#AB4AFF]/10 flex items-center justify-center text-[#AB4AFF] font-bold text-xl',
                            [text('⚡')],
                          ),
                        ],
                      ),

                      p(
                        classes:
                            'text-sm text-[#8A8A93] leading-relaxed',
                        [
                          text(
                            'Specializing in clean architectures, Bloc/Riverpod state patterns, offline-first sync, and high-performance cross-platform applications across iOS, Android, and Web.',
                          ),
                        ],
                      ),

                      // Tech pills
                      div(classes: 'flex flex-wrap gap-2 pt-2', [
                        for (var tech in [
                          'Flutter',
                          'Dart',
                          'Jaspr',
                          'Clean Arch',
                          'Firebase',
                          'TypeScript',
                        ])
                          span(
                            classes:
                                'px-3 py-1 rounded-lg text-xs font-medium bg-[#0A0A0C] border border-[#2A2A36] text-[#C4C4CC]',
                            [text(tech)],
                          ),
                      ]),
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
