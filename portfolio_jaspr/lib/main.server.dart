/// The entrypoint for the **server** environment.
library;

import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';

import 'app.dart';
import 'main.server.options.dart';

void main() {
  Jaspr.initializeApp(
    options: defaultServerOptions,
  );

  runApp(Document(
    title: 'Mohamed Ilham | Senior Mobile Engineer & Flutter Specialist',
    head: [
      link(href: '/styles.css', rel: 'stylesheet'),
      meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0'),
      meta(
        name: 'description',
        content:
            'Portfolio of Mohamed Ilham - Senior Mobile Engineer, Flutter Specialist, and Full-Stack Developer based in Sri Lanka.',
      ),
      meta(
        name: 'keywords',
        content:
            'Mohamed Ilham, Flutter Developer Sri Lanka, Top Flutter Developer, Senior Mobile Engineer, Dart, Jaspr, Mobile App Developer',
      ),
    ],
    body: const App(),
  ));
}
