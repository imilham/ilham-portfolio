import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import '../components/ambient_background.dart';
import '../components/navigation.dart';
import '../components/footer.dart';

class PrivacyPage extends StatelessComponent {
  const PrivacyPage({super.key});

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
                        [text('← ')],
                      ),
                      text('Back to Home'),
                    ]),
                  ),

                  // Header
                  div(classes: 'space-y-4 border-b border-white/10 pb-8', [
                    span(
                      classes:
                          'text-xs font-semibold text-[#AB4AFF] uppercase tracking-widest',
                      [text('Legal & Transparency')],
                    ),
                    h1(
                      classes:
                          'text-4xl sm:text-5xl font-extrabold text-white tracking-tight',
                      [
                        text('Privacy '),
                        span(classes: 'text-[#AB4AFF]', [text('Policy')]),
                      ],
                    ),
                    p(classes: 'text-sm text-[#A1A1AA]', [
                      text('Last updated: November 2026'),
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
                          [text('1. Overview')],
                        ),
                        p([
                          text(
                            'Your privacy is important. This Privacy Policy outlines the types of information collected when visiting this personal portfolio website and how that information is handled.',
                          ),
                        ]),
                      ]),

                      section([
                        h2(
                          classes:
                              'text-xl font-bold text-white mb-3 tracking-tight',
                          [text('2. Information We Collect')],
                        ),
                        p(classes: 'mb-3', [
                          text(
                            'This website does not collect personally identifiable information unless you voluntarily provide it, such as when sending a message through the contact form or reaching out directly via email.',
                          ),
                        ]),
                        ul(
                          classes:
                              'list-disc list-inside space-y-2 text-[#A1A1AA] pl-2',
                          [
                            li([
                              strong(classes: 'text-white', [
                                text('Contact Details: '),
                              ]),
                              text(
                                'Name, email address, and message content sent when contacting me.',
                              ),
                            ]),
                            li([
                              strong(classes: 'text-white', [
                                text('Usage Analytics: '),
                              ]),
                              text(
                                'Anonymous, privacy-first telemetry such as page views and browser device type to optimize site performance.',
                              ),
                            ]),
                          ],
                        ),
                      ]),

                      section([
                        h2(
                          classes:
                              'text-xl font-bold text-white mb-3 tracking-tight',
                          [text('3. How Your Information is Used')],
                        ),
                        p([
                          text(
                            'Any information provided is used strictly to respond to inquiries, discuss potential engineering collaborations, and ensure smooth technical operations. Your data will never be sold, rented, or shared with third-party advertisers.',
                          ),
                        ]),
                      ]),

                      section([
                        h2(
                          classes:
                              'text-xl font-bold text-white mb-3 tracking-tight',
                          [text('4. External Links & Services')],
                        ),
                        p([
                          text(
                            'This website contains links to external platforms (such as GitHub, LinkedIn, and live project deployments). I am not responsible for the privacy practices or content of external sites.',
                          ),
                        ]),
                      ]),

                      section([
                        h2(
                          classes:
                              'text-xl font-bold text-white mb-3 tracking-tight',
                          [text('5. Contact')],
                        ),
                        p([
                          text(
                            'If you have any questions or requests regarding this Privacy Policy, feel free to reach out via ',
                          ),
                          a(
                            href: '/#contact',
                            classes:
                                'text-[#AB4AFF] hover:underline font-medium',
                            [text('the contact form')],
                          ),
                          text('.'),
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
