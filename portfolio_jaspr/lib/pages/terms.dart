import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import '../components/ambient_background.dart';
import '../components/navigation.dart';
import '../components/footer.dart';

class TermsPage extends StatelessComponent {
  const TermsPage({super.key});

  @override
  Component build(BuildContext context) {
    return div(
      classes:
          'min-h-screen bg-[#040407] text-[#F4F4F6] flex flex-col justify-between relative selection:bg-[#AB4AFF] selection:text-white',
      [
        const AmbientBackground(),
        div(
          classes:
              'relative z-10 flex-1 flex flex-col justify-between min-h-screen',
          [
            div([
              const Navigation(),
              main_(
                classes:
                    'pt-32 pb-24 px-6 max-w-4xl mx-auto space-y-10 w-full',
                [
                  // Back Link
                  Link(
                    to: '/',
                    classes:
                        'inline-flex items-center gap-2 text-sm text-[#A1A1AA] hover:text-white transition-colors group',
                    child: span([
                      span(
                        classes:
                            'inline-block transition-transform group-hover:-translate-x-1',
                        [Component.text('← ')],
                      ),
                      Component.text('Back to Home'),
                    ]),
                  ),

                  // Header
                  div(classes: 'space-y-4 border-b border-white/10 pb-8', [
                    span(
                      classes:
                          'text-xs font-semibold text-[#AB4AFF] uppercase tracking-widest',
                      [Component.text('Legal & Terms')],
                    ),
                    h1(
                      classes:
                          'text-4xl sm:text-5xl font-extrabold text-white tracking-tight',
                      [
                        Component.text('Terms and '),
                        span(classes: 'text-[#AB4AFF]', [Component.text('Conditions')]),
                      ],
                    ),
                    p(classes: 'text-sm text-[#A1A1AA]', [
                      Component.text('Last updated: November 2026'),
                    ]),
                  ]),

                  // Content Sections
                  div(
                    classes:
                        'space-y-8 text-[#D4D4D8] text-base leading-relaxed',
                    [
                      section([
                        h2(
                          classes:
                              'text-xl font-bold text-white mb-3 tracking-tight',
                          [Component.text('1. Acceptance of Terms')],
                        ),
                        p([
                          Component.text(
                            'By accessing and using this portfolio website, you agree to comply with and be bound by the following terms and conditions. If you disagree with any part of these terms, please refrain from using the site.',
                          ),
                        ]),
                      ]),

                      section([
                        h2(
                          classes:
                              'text-xl font-bold text-white mb-3 tracking-tight',
                          [Component.text('2. Intellectual Property Rights')],
                        ),
                        p([
                          Component.text(
                            'All original articles, project showcases, designs, graphics, and source code authored on this site are the property of Mohamed Ilham unless otherwise specified. Open-source repositories linked from this site are governed by their respective licenses (e.g. MIT, Apache 2.0).',
                          ),
                        ]),
                      ]),

                      section([
                        h2(
                          classes:
                              'text-xl font-bold text-white mb-3 tracking-tight',
                          [Component.text('3. Permitted Use')],
                        ),
                        p([
                          Component.text(
                            'You may browse, read, and share links to this site for personal, non-commercial, and informational purposes. Re-publishing whole articles or claiming project ownership without explicit written permission is prohibited.',
                          ),
                        ]),
                      ]),

                      section([
                        h2(
                          classes:
                              'text-xl font-bold text-white mb-3 tracking-tight',
                          [Component.text('4. Disclaimer of Warranties')],
                        ),
                        p([
                          Component.text(
                            'The information, code snippets, and tutorials presented on this site are provided "as is" without warranty of any kind. While I endeavor to keep content accurate and up to date, I make no representations regarding completeness or fitness for a particular purpose.',
                          ),
                        ]),
                      ]),

                      section([
                        h2(
                          classes:
                              'text-xl font-bold text-white mb-3 tracking-tight',
                          [Component.text('5. Contact Information')],
                        ),
                        p([
                          Component.text(
                            'For inquiries or collaboration discussions concerning these terms, please contact me via ',
                          ),
                          a(
                            href: '/#contact',
                            classes:
                                'text-[#AB4AFF] hover:underline font-medium',
                            [Component.text('the contact section')],
                          ),
                          Component.text('.'),
                        ]),
                      ]),
                    ],
                  ),
                ],
              ),
            ]),
            const Footer(),
          ],
        ),
      ],
    );
  }
}
