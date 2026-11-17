import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class Footer extends StatelessComponent {
  const Footer({super.key});

  @override
  Component build(BuildContext context) {
    return footer(
      classes: 'py-10 px-6 bg-[#070709] border-t border-[#1A1A22]',
      [
        div(
          classes:
              'max-w-7xl mx-auto flex flex-col sm:flex-row items-center justify-between gap-4 text-xs text-[#8A8A93]',
          [
            div([
              text('© ${DateTime.now().year} Mohamed Ilham. All rights reserved.'),
            ]),
            div(classes: 'flex items-center gap-6', [
              a(
                href: '/#about',
                classes: 'hover:text-white transition-colors',
                [text('About')],
              ),
              a(
                href: '/#projects',
                classes: 'hover:text-white transition-colors',
                [text('Projects')],
              ),
              a(
                href: '/blog',
                classes: 'hover:text-white transition-colors',
                [text('Blog')],
              ),
              a(
                href: '/#contact',
                classes: 'hover:text-white transition-colors',
                [text('Contact')],
              ),
            ]),
          ],
        ),
      ],
    );
  }
}
