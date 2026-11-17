// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/client.dart';

import 'package:portfolio_jaspr/components/animated_rotating_title.dart'
    deferred as _animated_rotating_title;
import 'package:portfolio_jaspr/pages/admin.dart' deferred as _admin;
import 'package:portfolio_jaspr/pages/home.dart' deferred as _home;

/// Default [ClientOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.client.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultClientOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ClientOptions get defaultClientOptions => ClientOptions(
  clients: {
    'animated_rotating_title': ClientLoader(
      (p) => _animated_rotating_title.AnimatedRotatingTitle(
        titles: (p['titles'] as List<Object?>).cast<String>(),
        fallbackTagline: p['fallbackTagline'] as String,
      ),
      loader: _animated_rotating_title.loadLibrary,
    ),
    'admin': ClientLoader(
      (p) => _admin.AdminPage(),
      loader: _admin.loadLibrary,
    ),
    'home': ClientLoader((p) => _home.Home(), loader: _home.loadLibrary),
  },
);
