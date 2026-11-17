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
      link(rel: 'icon', type: 'image/svg+xml', href: '/favicon.svg'),
      link(rel: 'icon', type: 'image/x-icon', href: '/favicon.ico'),
      link(rel: 'apple-touch-icon', href: '/apple-touch-icon.png'),
      link(href: '/styles.css?v=2.2', rel: 'stylesheet'),
      link(rel: 'canonical', href: 'https://imilham.com/'),
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
      // Open Graph Tags
      meta(attributes: {'property': 'og:type', 'content': 'website'}),
      meta(attributes: {'property': 'og:url', 'content': 'https://imilham.com/'}),
      meta(attributes: {
        'property': 'og:title',
        'content': 'Mohamed Ilham | Senior Mobile Engineer & Flutter Specialist'
      }),
      meta(attributes: {
        'property': 'og:description',
        'content':
            'Senior Mobile Engineer & Flutter Specialist with 3+ years building high-performance cross-platform applications.'
      }),
      meta(attributes: {
        'property': 'og:image',
        'content': 'https://imilham.com/icon-512.png'
      }),
      // Twitter Card Tags
      meta(attributes: {'name': 'twitter:card', 'content': 'summary'}),
      meta(attributes: {'name': 'twitter:site', 'content': '@imilham'}),
      meta(attributes: {
        'name': 'twitter:title',
        'content': 'Mohamed Ilham | Senior Mobile Engineer & Flutter Specialist'
      }),
      meta(attributes: {
        'name': 'twitter:description',
        'content':
            'Senior Mobile Engineer & Flutter Specialist with 3+ years building high-performance cross-platform applications.'
      }),
      meta(attributes: {
        'name': 'twitter:image',
        'content': 'https://imilham.com/icon-512.png'
      }),
    ],
    body: const App(),
  ));
}
