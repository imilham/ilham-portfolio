import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class Footer extends StatelessComponent {
  const Footer({super.key});

  @override
  Component build(BuildContext context) {
    return footer(
      classes: 'py-12 px-6 bg-[#070709] border-t border-[#1A1A22]',
      [
        div(
          classes:
              'max-w-7xl mx-auto flex flex-col sm:flex-row items-center justify-between gap-6 text-xs text-[#8A8A93]',
          [
            div([
              text('© ${DateTime.now().year} Mohamed Ilham. All rights reserved.'),
            ]),
            div(classes: 'flex items-center gap-2', [
              text('Engineered with '),
              a(
                href: 'https://jaspr.site',
                target: Target.blank,
                classes: 'text-[#AB4AFF] hover:underline font-semibold',
                [text('Jaspr (Dart)')],
              ),
              text(' & Tailwind CSS • Powered by the same tech as '),
              a(
                href: 'https://flutter.dev',
                target: Target.blank,
                classes: 'text-white hover:underline font-semibold',
                [text('flutter.dev')],
              ),
            ]),
          ],
        ),
      ],
    );
  }
}
