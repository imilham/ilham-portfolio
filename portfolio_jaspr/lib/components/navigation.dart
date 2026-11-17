import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

class Navigation extends StatelessComponent {
  const Navigation({super.key});

  @override
  Component build(BuildContext context) {
    return nav(
      classes:
          'fixed top-0 left-0 right-0 z-50 bg-[#0A0A0C]/85 backdrop-blur-md border-b border-[#1A1A22] transition-all',
      [
        div(
          classes:
              'max-w-7xl mx-auto px-6 py-4 flex items-center justify-between',
          [
            // Logo
            Link(
              to: '/',
              classes: 'text-2xl font-bold tracking-tight text-white hover:opacity-90',
              child: span([
                text('imilham'),
                span(classes: 'text-[#AB4AFF]', [text('.')]),
              ]),
            ),

            // Navigation Links
            div(classes: 'hidden md:flex items-center gap-8', [
              a(
                href: '/#about',
                classes:
                    'text-sm font-medium text-[#C4C4CC] hover:text-[#AB4AFF] transition-colors',
                [text('About')],
              ),
              a(
                href: '/#projects',
                classes:
                    'text-sm font-medium text-[#C4C4CC] hover:text-[#AB4AFF] transition-colors',
                [text('Projects')],
              ),
              a(
                href: '/#gallery',
                classes:
                    'text-sm font-medium text-[#C4C4CC] hover:text-[#AB4AFF] transition-colors',
                [text('Gallery')],
              ),
              Link(
                to: '/blog',
                classes:
                    'text-sm font-medium text-[#C4C4CC] hover:text-[#AB4AFF] transition-colors',
                child: text('Blog'),
              ),
              a(
                href: '/#contact',
                classes:
                    'px-4 py-2 rounded-lg text-sm font-semibold text-white bg-[#AB4AFF] hover:bg-[#9732f0] transition-colors shadow-lg shadow-[#AB4AFF]/20',
                [text('Get in Touch')],
              ),
            ]),

            // Mobile menu button indicator
            div(classes: 'md:hidden flex items-center gap-3', [
              Link(
                to: '/blog',
                classes: 'text-sm font-medium text-[#C4C4CC]',
                child: text('Blog'),
              ),
              a(
                href: '/#projects',
                classes:
                    'px-3 py-1.5 rounded-lg text-xs font-semibold text-white bg-[#AB4AFF]',
                [text('Projects')],
              ),
            ]),
          ],
        ),
      ],
    );
  }
}
