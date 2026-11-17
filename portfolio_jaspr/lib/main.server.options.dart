// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:portfolio_jaspr/constants/theme.dart' as _theme;
import 'package:portfolio_jaspr/pages/admin.dart' as _admin;
import 'package:portfolio_jaspr/app.dart' as _app;

/// Default [ServerOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.server.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultServerOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ServerOptions get defaultServerOptions => ServerOptions(
  clientId: 'main.client.dart.js',
  clients: {_admin.AdminPage: ClientTarget<_admin.AdminPage>('admin')},
  styles: () => [..._theme.styles, ..._app.App.styles],
);
