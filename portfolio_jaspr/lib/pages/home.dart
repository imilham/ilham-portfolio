import 'dart:convert';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;
import '../data/portfolio_data.dart';
import '../models/site_data.dart';
import '../core/services/firebase_service.dart';
import '../components/ambient_background.dart';
import '../components/navigation.dart';
import '../components/hero_section.dart';
import '../components/about_section.dart';
import '../components/projects_section.dart';
import '../components/gallery_section.dart';
import '../components/contact_section.dart';
import '../components/footer.dart';

class Home extends StatefulComponent {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SiteData _data = defaultSiteData;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      try {
        final cached = web.window.localStorage.getItem('cached_site_data');
        if (cached != null && cached.isNotEmpty) {
          final decoded = jsonDecode(cached) as Map<String, dynamic>;
          final parsed = SiteData.fromJson(decoded);
          if (parsed.profile.heroPhoto.isNotEmpty) {
            _data = parsed;
          }
        }
      } catch (_) {}
    }
    _loadFirebaseData();
  }

  void _loadFirebaseData() async {
    try {
      final liveData = await FirebaseService.fetchSiteData();
      if (mounted && liveData.profile.heroPhoto.isNotEmpty) {
        setState(() {
          _data = liveData;
        });
        if (kIsWeb) {
          try {
            web.window.localStorage.setItem(
              'cached_site_data',
              jsonEncode(liveData.toJson()),
            );
          } catch (_) {}
        }
      }
    } catch (_) {
      // Retain defaultSiteData or cached data seamlessly if offline
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes:
          'min-h-screen bg-[#020204] text-[#F4F4F6] relative selection:bg-[#AB4AFF] selection:text-white',
      [
        // Living Ambient Animated Canvas
        const AmbientBackground(),

        // Foreground Content
        const Navigation(),
        div(classes: 'relative z-10', [
          HeroSection(profile: _data.profile),
          AboutSection(
            profile: _data.profile,
            education: _data.education,
            experience: _data.experience,
          ),
          ProjectsSection(projects: _data.projects),
          GallerySection(gallery: _data.gallery),
          ContactSection(profile: _data.profile),
          const Footer(),
        ]),
      ],
    );
  }
}
