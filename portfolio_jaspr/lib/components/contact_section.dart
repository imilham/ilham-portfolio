import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import '../models/profile.dart';

class ContactSection extends StatelessComponent {
  final Profile profile;

  const ContactSection({required this.profile, super.key});

  @override
  Component build(BuildContext context) {
    return section(
      id: 'contact',
      classes: 'py-24 px-6 bg-transparent border-t border-[#1A1A22]/60',
      [
        div(classes: 'max-w-5xl mx-auto space-y-12 text-center', [
          // Header
          div(classes: 'space-y-4 max-w-2xl mx-auto', [
            span(
              classes:
                  'text-xs font-semibold text-[#AB4AFF] uppercase tracking-wider',
              [text("Let's Collaborate")],
            ),
            h2(
              classes:
                  'text-3xl sm:text-5xl font-extrabold tracking-tight text-white',
              [
                text('Ready to Build Something '),
                span(classes: 'text-[#AB4AFF]', [text('Extraordinary?')]),
              ],
            ),
            p(
              classes: 'text-base sm:text-lg text-[#8A8A93] leading-relaxed',
              [
                text(
                  'Whether you have an ambitious mobile app concept, an architecture consultation, or a contract opportunity, my inbox is always open.',
                ),
              ],
            ),
          ]),

          // Contact Box
          div(
            classes:
                'p-8 sm:p-12 rounded-3xl bg-gradient-to-b from-[#121216] to-[#0D0D10] border border-[#2A2A36] max-w-xl mx-auto space-y-8 shadow-2xl',
            [
              div(classes: 'space-y-2', [
                div(
                  classes: 'text-xs uppercase tracking-wider text-[#8A8A93]',
                  [text('Direct Inquiries')],
                ),
                a(
                  href: 'mailto:${profile.email}',
                  classes:
                      'text-xl sm:text-2xl font-bold text-white hover:text-[#AB4AFF] transition-colors',
                  [text(profile.email.isNotEmpty ? profile.email : 'hello@imilham.com')],
                ),
              ]),

              div(classes: 'flex flex-wrap justify-center gap-4', [
                if (profile.github.isNotEmpty)
                  _socialLink('GitHub', profile.github),
                if (profile.linkedin.isNotEmpty)
                  _socialLink('LinkedIn', profile.linkedin),
                if (profile.twitter.isNotEmpty)
                  _socialLink('Twitter / X', profile.twitter),
              ]),

              div(classes: 'pt-4 border-t border-[#1A1A22] text-xs text-[#8A8A93]', [
                text('📍 Based in ${profile.location.isNotEmpty ? profile.location : "Colombo, Sri Lanka"} • Remote Worldwide'),
              ]),
            ],
          ),
        ]),
      ],
    );
  }

  Component _socialLink(String title, String url) {
    return a(
      href: url,
      target: Target.blank,
      classes:
          'px-4 py-2 rounded-xl text-xs font-semibold bg-[#1A1A22] text-[#C4C4CC] hover:text-white hover:bg-[#2A2A36] border border-[#2A2A36] transition-all',
      [text(title)],
    );
  }
}
