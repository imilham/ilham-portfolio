import '../models/profile.dart';
import '../models/education_experience.dart';
import '../models/portfolio_items.dart';
import '../models/site_data.dart';

const defaultSiteData = SiteData(
  profile: Profile(
    name: 'Mohamed Ilham',
    tagline: 'Senior Mobile Engineer & Flutter Specialist',
    bio:
        'Results-driven Flutter Engineer with 2+ years of experience delivering high-performance, cross-platform mobile applications. Specialized in clean architecture, modular code separation, and pixel-perfect UI implementation. Proven track record in optimizing app performance, secure API integration, and setting up automated CI/CD pipelines. A proactive technical leader committed to engineering excellence, actively mentoring junior developers and driving team-wide adoption of best practices and development standards.',
    location: 'Colombo, Sri Lanka',
    email: 'hello@imilham.com',
    github: 'https://github.com',
    linkedin: 'https://linkedin.com',
    twitter: 'https://twitter.com',
    heroPhoto: 'https://drive.google.com/file/d/1Rb0fKjZ3p8nXGwdW85jBJbNVWEDPCK_V/view?usp=sharing',
    siteTitle: 'Mohamed Ilham — Software Engineer',
    cvUrl: 'https://drive.google.com/file/d/1ABa6q4_hV8nqEusknLIdpXfdLTomS9KQ/view?usp=sharing',
    enableCarousel: true,
    carouselTexts: [
      'Senior Mobile Engineer',
      'Flutter Specialist',
      'Entrepreneur',
    ],
    skills: [
      'Flutter',
      'Dart',
      'Firebase',
      'iOS',
      'Android',
      'Clean Architecture',
      'CI/CD',
      'Tailwind CSS',
      'REST APIs',
      'MySQL',
    ],
    certifications: [
      'Flutter Development Expert',
      'AWS Certified Solutions Architect',
      'Google Cloud Professional Developer',
    ],
    stats: [
      StatItem(label: 'Projects', value: '15+'),
      StatItem(label: 'Years Exp.', value: '3+'),
      StatItem(label: 'Happy Clients', value: '15+'),
    ],
  ),
  education: [
    Education(
      id: '1',
      degree: 'BSc Computing - Reading',
      school: 'Wrexham Glyndwr University – UK',
      year: 'Present',
      description: 'Specialized in Software Engineering and Artificial Intelligence.',
    ),
    Education(
      id: 'yzh610q6a8c',
      degree: 'Higher National Diploma In Software Engineering',
      school: 'National Institute Of Business Management',
      year: '2023 – 2024',
      description: 'Comprehensive training in software systems, algorithms, and cross-platform architecture.',
    ),
  ],
  experience: [
    Experience(
      id: '1',
      role: 'Senior Mobile / Flutter Developer',
      company: 'Tech Solutions',
      period: 'Jan 2024 – Present',
      description:
          'Architecting and scaling cross-platform mobile applications with Clean Architecture and state management.',
      technologies: ['Flutter', 'Dart', 'Bloc', 'Firebase', 'REST APIs'],
    ),
  ],
  projects: [
    Project(
      id: '1',
      title: 'Wathiq',
      description:
          'A cross-platform ecosystem built to connect Sri Lankan Muslims globally. The platform features a highly modular architecture supporting real-time peer-to-peer networking, inter-community service directories, and complex financial logic for automated Zakat calculation and distribution.',
      tags: ['Flutter', 'Dart', 'MySQL', '.NET', 'Cloudflare', 'GitHub'],
      liveUrl: 'https://wathiq.lk',
      githubUrl: '#',
      featured: true,
      image: 'https://drive.google.com/file/d/1dkPYQXbiMb88Bz7fLJsUvgyCUvOKoXtu/view?usp=sharing',
    ),
    Project(
      id: 'phypbkl8ok',
      title: 'Manamali',
      description:
          'A high-security matrimonial super-app engineered with a modular, hub-and-spoke architecture. Features a multi-step user onboarding pipeline, AI-driven identity verification with liveness checks, and a cross-platform codebase supporting secure matchmaking.',
      tags: ['Flutter', 'Dart', 'Laravel', 'PHP'],
      liveUrl: 'https://wathiq.cyberpilum.com',
      githubUrl: '#',
      featured: true,
      image: 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=800&q=80',
    ),
  ],
  gallery: [
    GalleryPhoto(
      id: '1',
      url: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80',
      caption: 'Mountain sunrise',
      category: 'Travel',
    ),
    GalleryPhoto(
      id: '2',
      url: 'https://images.unsplash.com/photo-1519501025264-65ba15a82390?w=800&q=80',
      caption: 'City lights',
      category: 'Urban',
    ),
  ],
  blog: [
    BlogPost(
      id: '23whug2d715',
      title: 'Flutter 3.44 is making one of the biggest iOS changes in years.',
      slug: 'flutter-3-44-swift-package-manager',
      excerpt:
          'CocoaPods is no longer the default dependency manager for iOS and macOS projects. Flutter is moving to Swift Package Manager (SwiftPM), Apple\'s built-in dependency management system.',
      content: '''
# Flutter 3.44 is making one of the biggest iOS changes in years.

CocoaPods is no longer the default dependency manager for iOS and macOS projects.

Flutter is moving to Swift Package Manager (SwiftPM), Apple's built-in dependency management system.

## Why is this a big deal?

If you've worked on Flutter iOS apps before, you've probably seen issues like:

- CocoaPods installation problems
- Ruby version conflicts
- pod install failures
- CI/CD setup headaches
- Random dependency-related build errors

SwiftPM helps reduce a lot of that because it is already built into Xcode. No separate CocoaPods installation is required for projects that can fully use SwiftPM.

## How do you enable it?

1. Upgrade Flutter
2. Run:
```bash
flutter config --enable-swift-package-manager
```
3. Build or run your iOS app

Flutter will automatically try to migrate the Xcode project and add SwiftPM integration for you.

## What about existing projects?

Flutter is designed to avoid breaking existing apps. If a plugin does not support SwiftPM yet, Flutter can automatically fall back to CocoaPods for that dependency. This makes migration much safer for real-world projects.

## Things worth checking before migrating:
- Use a recent Flutter version
- Update plugins to their latest versions where possible
- Verify any custom iOS build scripts
- Test your CI/CD pipeline after migration
''',
      tags: ['Flutter', 'iOSDevelopment', 'SwiftPM', 'SwiftPackageManager', 'MobileDevelopment'],
      coverImage:
          'https://media.licdn.com/dms/image/v2/D4D22AQGRmGRkI_jnsA/feedshare-shrink_1280/B4DZ66mLGjJAAM-/0/1781247030146?e=1782950400&v=beta&t=NsTFwA2T9dt4bMd7j_RrvPlibW908A2hw-QKIA-NYXQ',
      publishedAt: '2026-06-13',
      published: true,
    ),
    BlogPost(
      id: 'why-jaspr-dart-web-post',
      title: 'Why Jaspr is the Best Way to Build Web Apps in Dart',
      slug: 'why-jaspr-dart-web',
      excerpt:
          'How Google built flutter.dev with Jaspr, and how you can leverage pure Dart for fast, SEO-friendly websites.',
      content: '''
# Why Jaspr is the Best Way to Build Web Apps in Dart

For years, Flutter developers faced a dilemma: Flutter Web is fantastic for complex interactive canvases and applications, but for SEO-critical marketing pages and blogs, HTML/CSS is king.

Enter **Jaspr**—the open-source Dart web framework powering `flutter.dev`.

## Key Benefits of Jaspr:
1. **Real HTML & CSS**: No canvas rendering issues or pixelated text.
2. **Flutter-like Syntax**: Uses `StatelessComponent` and `StatefulComponent`.
3. **Static Site Generation (SSG)**: Fast loading and top SEO rankings.
''',
      tags: ['Dart', 'Jaspr', 'Flutter', 'Web'],
      coverImage: 'https://images.unsplash.com/photo-1633356122102-3fe601e05bd2?w=800&q=80',
      publishedAt: '2026-11-17',
      published: true,
    ),
  ],
);
