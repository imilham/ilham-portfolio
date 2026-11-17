import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

class Footer extends StatelessComponent {
  const Footer({super.key});

  @override
  Component build(BuildContext context) {
    return footer(
      classes:
          'relative z-20 py-10 px-6 sm:px-10 bg-[#040407]/80 backdrop-blur-md border-t border-[#1C1C28]',
      [
        div(
          classes:
              'max-w-7xl mx-auto flex flex-col md:flex-row items-center justify-between gap-8 text-xs',
          [
            // Left: Brand logo
            div(classes: 'flex items-center gap-3', [
              Link(
                to: '/',
                classes:
                    'text-base font-bold tracking-tight text-white hover:text-[#AB4AFF] transition-colors flex items-center',
                child: span([
                  text('imilham'),
                  span(classes: 'text-[#AB4AFF]', [text('.')]),
                ]),
              ),
            ]),

            // Center: Copyright Statement
            div(
              classes:
                  'text-[#8E8EA0] text-center tracking-wide font-normal order-last md:order-none',
              [
                text('All rights reserved © 2024 - 2026'),
              ],
            ),

            // Right: Status indicator, Privacy Policy & Terms Links
            div(
              classes:
                  'flex flex-col items-center md:items-end gap-2 text-xs text-[#8E8EA0]',
              [
                // Status with animated live green dot
                a(
                  href: '/#contact',
                  classes:
                      'group inline-flex items-center gap-2 text-[#8E8EA0] hover:text-white transition-colors cursor-pointer',
                  [
                    span(classes: 'relative flex h-2 w-2', [
                      span(
                        classes:
                            'animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75',
                        [],
                      ),
                      span(
                        classes:
                            'relative inline-flex rounded-full h-2 w-2 bg-emerald-500 shadow-[0_0_8px_rgba(16,185,129,0.8)]',
                        [],
                      ),
                    ]),
                    span(
                      classes:
                          'text-xs font-medium text-[#D4D4D8] group-hover:text-white transition-colors',
                      [text('Status')],
                    ),
                  ],
                ),

                // Privacy Policy Link
                Link(
                  to: '/privacy',
                  classes:
                      'text-xs text-[#8E8EA0] hover:text-[#AB4AFF] transition-colors font-normal',
                  child: span([text('Privacy Policy')]),
                ),

                // Terms and Conditions Link
                Link(
                  to: '/terms',
                  classes:
                      'text-xs text-[#8E8EA0] hover:text-[#AB4AFF] transition-colors font-normal',
                  child: span([text('Terms and Conditions')]),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
