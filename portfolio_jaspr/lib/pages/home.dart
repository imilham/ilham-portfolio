import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
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
    _loadFirebaseData();
  }

  void _loadFirebaseData() async {
    try {
      final liveData = await FirebaseService.fetchSiteData();
      if (mounted && liveData.profile.heroPhoto.isNotEmpty) {
        setState(() {
          _data = liveData;
        });
      }
    } catch (_) {
      // Retain defaultSiteData seamlessly if offline
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes:
          'min-h-screen bg-[#0A0A0C] text-[#F4F4F6] relative selection:bg-[#AB4AFF] selection:text-white',
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
