import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import '../models/profile.dart';
import '../core/utils/drive_utils.dart';
import 'cv_modal.dart';

class HeroSection extends StatelessComponent {
  final Profile profile;

  const HeroSection({required this.profile, super.key});

  @override
  Component build(BuildContext context) {
    // Resolve Firebase / Google Drive profile image using drive_utils
    final resolvedPhoto = getDriveViewUrl(profile.heroPhoto);
    final photoUrl = resolvedPhoto.isNotEmpty
        ? resolvedPhoto
        : 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=900&auto=format&fit=crop&q=80';

    final cvDownloadUrl = getDriveDownloadUrl(profile.cvUrl);
    final cvPreviewUrl = getDrivePreviewUrl(profile.cvUrl);
    final cvExternalViewUrl = getDriveExternalViewUrl(profile.cvUrl);

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

                  // "View CV" Pill Button with Glowing Border (Opens Interactive Modal)
                  button(
                    id: 'open-cv-modal-btn',
                    classes:
                        'inline-flex items-center justify-center gap-2 px-8 py-3.5 rounded-full font-bold text-sm text-white bg-[#0A0A0E]/80 border-2 border-[#38BDF8]/60 hover:border-[#38BDF8] hover:bg-[#38BDF8]/15 hover:shadow-lg hover:shadow-[#38BDF8]/25 transition-all duration-300 hover:scale-105 cursor-pointer',
                    [
                      span(classes: 'text-base', [text('📄')]),
                      text('View CV'),
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

              // Right Column: Seamless Atmospheric Portrait Blend (Natural depth, no hard "moon" circle)
              div(
                classes:
                    'lg:col-span-5 flex justify-center lg:justify-end relative items-center',
                [
                  // Ambient Atmospheric Aura behind the portrait (Studio Rim Lighting)
                  div(classes: 'portrait-soft-aura', []),

                  // Seamless Portrait Container with Gentle Top Arch & Soft Dissolving Bottom
                  div(
                    classes:
                        'relative w-72 sm:w-88 lg:w-[420px] h-[360px] sm:h-[440px] lg:h-[490px] portrait-blend-wrapper transition-transform duration-500 hover:scale-[1.02] group z-10',
                    [
                      div(
                        classes:
                            'w-full h-full rounded-t-[140px] sm:rounded-t-[180px] lg:rounded-t-[210px] rounded-b-2xl overflow-hidden bg-transparent relative border-t border-x border-[#AB4AFF]/30',
                        [
                          img(
                            src: photoUrl,
                            alt: profile.name,
                            classes:
                                'w-full h-full object-cover object-top filter brightness-[0.98] contrast-[1.05] group-hover:scale-105 transition-transform duration-700',
                            attributes: {
                              'loading': 'eager',
                              'decoding': 'async',
                              'referrerpolicy': 'no-referrer',
                            },
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

        // Interactive CV Preview Modal (In-Page PDF Viewer & Direct Download)
        CvModal(
          cvDownloadUrl: cvDownloadUrl,
          cvPreviewUrl: cvPreviewUrl,
          cvExternalViewUrl: cvExternalViewUrl,
        ),
      ],
    );
  }
}
