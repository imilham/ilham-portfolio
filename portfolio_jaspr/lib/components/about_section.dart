import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import '../models/profile.dart';
import '../models/education_experience.dart';

class AboutSection extends StatelessComponent {
  final Profile profile;
  final List<Education> education;
  final List<Experience> experience;

  const AboutSection({
    required this.profile,
    required this.education,
    required this.experience,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return section(
      id: 'about',
      classes: 'py-24 px-6 bg-transparent border-t border-[#1A1A22]/60',
      [
        div(classes: 'max-w-7xl mx-auto space-y-16', [
          // Section Title
          div(classes: 'space-y-3', [
            span(
              classes:
                  'text-xs font-semibold text-[#AB4AFF] uppercase tracking-wider',
              [Component.text('Background & Skills')],
            ),
            h2(
              classes: 'text-3xl sm:text-5xl font-bold tracking-tight text-white',
              [
                Component.text('About '),
                span(classes: 'text-[#AB4AFF]', [Component.text('Me')]),
              ],
            ),
          ]),

          // Main 2-column layout
          div(classes: 'grid grid-cols-1 lg:grid-cols-12 gap-12', [
            // Left Column: Bio
            div(
              classes: (profile.skills.isNotEmpty || profile.certifications.isNotEmpty)
                  ? 'lg:col-span-6 space-y-6'
                  : 'lg:col-span-12 space-y-6',
              [
                p(
                  classes: 'text-base sm:text-lg text-[#A1A1AA] leading-relaxed',
                  [Component.text(profile.bio)],
                ),
              ],
            ),

            // Right Column: Skills & Certifications
            if (profile.skills.isNotEmpty || profile.certifications.isNotEmpty)
              div(classes: 'lg:col-span-6 space-y-8', [
                // Skills
                if (profile.skills.isNotEmpty)
                  div(
                    classes:
                        'p-6 rounded-2xl bg-[#121216] border border-[#1A1A22] space-y-4',
                    [
                      h3(classes: 'text-lg font-bold text-white', [
                        Component.text('Technical Skills'),
                      ]),
                      div(classes: 'flex flex-wrap gap-2', [
                        for (var skill in profile.skills)
                          span(
                            classes:
                                'px-3 py-1.5 rounded-lg text-xs font-semibold bg-[#1A1A22] text-[#F4F4F6] border border-[#2A2A36]',
                            [Component.text(skill)],
                          ),
                      ]),
                    ],
                  ),

                // Certifications
                if (profile.certifications.isNotEmpty)
                  div(
                    classes:
                        'p-6 rounded-2xl bg-[#121216] border border-[#1A1A22] space-y-4',
                    [
                      h3(classes: 'text-lg font-bold text-white', [
                        Component.text('Certifications & Accreditations'),
                      ]),
                      div(classes: 'space-y-3', [
                        for (var cert in profile.certifications)
                          div(classes: 'flex items-center gap-3', [
                            span(
                              classes:
                                  'w-6 h-6 rounded-full bg-[#AB4AFF]/10 text-[#AB4AFF] flex items-center justify-center text-xs font-bold shrink-0',
                              [Component.text('✓')],
                            ),
                            span(
                              classes: 'text-sm font-medium text-[#C4C4CC]',
                              [Component.text(cert)],
                            ),
                          ]),
                      ]),
                    ],
                  ),
              ]),
          ]),

          // Experience & Education Cards
          if (experience.isNotEmpty || education.isNotEmpty)
            div(classes: 'grid grid-cols-1 md:grid-cols-2 gap-8 pt-6', [
              // Experience
              if (experience.isNotEmpty)
                div(
                  classes:
                      'p-6 sm:p-8 rounded-2xl bg-[#121216] border border-[#1A1A22] space-y-6',
                  [
                    h3(classes: 'text-xl font-bold text-white flex items-center gap-2', [
                      Component.text('💼 Experience'),
                    ]),
                    for (var exp in experience)
                      div(classes: 'space-y-2 border-l-2 border-[#AB4AFF] pl-4', [
                        div(classes: 'flex justify-between items-baseline', [
                          h4(classes: 'text-base font-semibold text-white', [
                            Component.text(exp.role),
                          ]),
                          span(classes: 'text-xs text-[#8A8A93]', [Component.text(exp.period)]),
                        ]),
                        div(classes: 'text-sm font-medium text-[#AB4AFF]', [
                          Component.text(exp.company),
                        ]),
                        p(classes: 'text-xs text-[#8A8A93] leading-relaxed', [
                          Component.text(exp.description),
                        ]),
                      ]),
                  ],
                ),

              // Education
              if (education.isNotEmpty)
                div(
                  classes:
                      'p-6 sm:p-8 rounded-2xl bg-[#121216] border border-[#1A1A22] space-y-6',
                  [
                    h3(classes: 'text-xl font-bold text-white flex items-center gap-2', [
                      Component.text('🎓 Education'),
                    ]),
                    for (var edu in education)
                      div(classes: 'space-y-2 border-l-2 border-[#AB4AFF] pl-4', [
                        div(classes: 'flex justify-between items-baseline', [
                          h4(classes: 'text-base font-semibold text-white', [
                            Component.text(edu.degree),
                          ]),
                          span(classes: 'text-xs text-[#8A8A93]', [Component.text(edu.year)]),
                        ]),
                        div(classes: 'text-sm font-medium text-[#AB4AFF]', [
                          Component.text(edu.school),
                        ]),
                        p(classes: 'text-xs text-[#8A8A93] leading-relaxed', [
                          Component.text(edu.description),
                        ]),
                      ]),
                  ],
                ),
            ]),
        ]),
      ],
    );
  }
}
