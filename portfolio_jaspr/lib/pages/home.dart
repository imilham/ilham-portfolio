import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import '../data/portfolio_data.dart';
import '../components/navigation.dart';
import '../components/hero_section.dart';
import '../components/about_section.dart';
import '../components/projects_section.dart';
import '../components/gallery_section.dart';
import '../components/contact_section.dart';
import '../components/footer.dart';

class Home extends StatelessComponent {
  const Home({super.key});

  @override
  Component build(BuildContext context) {
    final data = defaultSiteData;

    return div(classes: 'min-h-screen bg-[#0A0A0C] text-[#F4F4F6]', [
      const Navigation(),
      HeroSection(profile: data.profile),
      AboutSection(
        profile: data.profile,
        education: data.education,
        experience: data.experience,
      ),
      ProjectsSection(projects: data.projects),
      GallerySection(gallery: data.gallery),
      ContactSection(profile: data.profile),
      const Footer(),
    ]);
  }
}
