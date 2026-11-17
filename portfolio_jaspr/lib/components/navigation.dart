import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

class Navigation extends StatelessComponent {
  const Navigation({super.key});

  @override
  Component build(BuildContext context) {
    const avatarPlaceholder =
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=120&auto=format&fit=crop&q=80';

    return nav(
      classes:
          'fixed top-0 left-0 right-0 z-50 bg-[#0A0A0C]/85 backdrop-blur-md border-b border-[#1A1A22] transition-all',
      [
        div(
          classes:
              'max-w-7xl mx-auto px-6 py-3.5 flex items-center justify-between',
          [
            // Logo
            Link(
              to: '/',
              classes:
                  'text-2xl font-bold tracking-tight text-white hover:opacity-90 flex items-center gap-1.5',
              child: span([
                text('imilham'),
                span(classes: 'text-[#AB4AFF]', [text('.')]),
              ]),
            ),

            // Desktop Navigation Links
            div(classes: 'hidden md:flex items-center gap-7', [
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
              // Top-right Profile Avatar Chip
              a(
                href: '/#about',
                classes:
                    'relative w-9 h-9 rounded-full ring-2 ring-[#AB4AFF]/50 overflow-hidden bg-[#1A1A24] flex items-center justify-center hover:ring-[#AB4AFF] hover:scale-105 transition-all shadow-md group',
                [
                  img(
                    src: avatarPlaceholder,
                    alt: 'Mohamed Ilham Profile',
                    classes: 'w-full h-full object-cover',
                  ),
                  span(
                    classes:
                        'absolute bottom-0 right-0 w-2.5 h-2.5 rounded-full bg-emerald-400 ring-2 ring-[#0A0A0C]',
                    [],
                  ),
                ],
              ),
            ]),

            // Mobile menu indicator with mini avatar
            div(classes: 'md:hidden flex items-center gap-3', [
              Link(
                to: '/blog',
                classes: 'text-sm font-medium text-[#C4C4CC]',
                child: text('Blog'),
              ),
              a(
                href: '/#contact',
                classes:
                    'px-3 py-1.5 rounded-lg text-xs font-semibold text-white bg-[#AB4AFF]',
                [text('Contact')],
              ),
              a(
                href: '/#about',
                classes:
                    'relative w-8 h-8 rounded-full ring-2 ring-[#AB4AFF]/60 overflow-hidden bg-[#1A1A24]',
                [
                  img(
                    src: avatarPlaceholder,
                    alt: 'Profile',
                    classes: 'w-full h-full object-cover',
                  ),
                ],
              ),
            ]),
          ],
        ),
      ],
    );
  }
}
