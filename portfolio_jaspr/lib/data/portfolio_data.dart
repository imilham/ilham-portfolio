import '../models/profile.dart';
import '../models/education_experience.dart';
import '../models/portfolio_items.dart';
import '../models/site_data.dart';

const defaultSiteData = SiteData(
  profile: Profile(
    name: 'Ilham',
    tagline: 'Senior Mobile Engineer & Flutter Specialist',
    bio: "I'm a passionate full-stack & mobile developer crafting high-performance, beautiful user experiences. I specialize in Flutter, Dart, React, TypeScript, and modern scalable architectures.",
    location: 'Colombo, Sri Lanka',
    email: 'hello@example.com',
    github: 'https://github.com',
    linkedin: 'https://linkedin.com',
    twitter: 'https://twitter.com',
    heroPhoto: '',
    siteTitle: 'Mohamed Ilham | Flutter Developer',
    cvUrl: '',
    enableCarousel: true,
    carouselTexts: [
      'Senior Mobile Engineer',
      'Flutter & Dart Specialist',
      'Full-Stack Developer',
    ],
    skills: [
      'Flutter',
      'Dart',
      'React',
      'TypeScript',
      'Next.js',
      'Tailwind CSS',
      'Firebase',
      'PostgreSQL',
      'Docker',
      'AWS',
      'CI/CD',
    ],
    certifications: [
      'Flutter Development Expert',
      'AWS Certified Solutions Architect',
      'Google Cloud Professional Developer',
      'Certified Kubernetes Administrator',
    ],
    stats: [
      StatItem(label: 'Projects', value: '20+'),
      StatItem(label: 'Years Exp.', value: '3+'),
      StatItem(label: 'Happy Clients', value: '15+'),
    ],
  ),
  education: [
    Education(
      id: '1',
      degree: 'BSc in Computer Science',
      school: 'University of Colombo',
      year: '2020 – 2024',
      description: 'Specialized in Software Engineering and Mobile Architectures.',
    ),
  ],
  experience: [
    Experience(
      id: '1',
      role: 'Senior Mobile / Flutter Developer',
      company: 'Tech Solutions',
      period: 'Jan 2024 – Present',
      description: 'Architecting and scaling cross-platform mobile applications with Clean Architecture and state management.',
      technologies: ['Flutter', 'Dart', 'Bloc', 'Firebase', 'REST APIs'],
    ),
  ],
  projects: [
    Project(
      id: '1',
      title: 'Cross-Platform Mobile Suite',
      description: 'Production Flutter application with real-time sync, offline-first architecture, and custom animations.',
      tags: ['Flutter', 'Dart', 'Firebase', 'State Management'],
      liveUrl: 'https://github.com',
      githubUrl: 'https://github.com',
      featured: true,
      image: 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=800&q=80',
    ),
    Project(
      id: '2',
      title: 'Jaspr Web Portfolio',
      description: 'High-performance web portfolio built using Jaspr and Tailwind CSS, mirroring the flutter.dev architecture.',
      tags: ['Jaspr', 'Dart', 'Tailwind CSS', 'SSG'],
      liveUrl: 'https://github.com',
      githubUrl: 'https://github.com',
      featured: true,
      image: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800&q=80',
    ),
    Project(
      id: '3',
      title: 'Cloud Analytics Dashboard',
      description: 'Interactive analytics dashboard with dynamic charting, role-based auth, and automated metrics aggregation.',
      tags: ['React', 'TypeScript', 'Tailwind', 'Cloud Functions'],
      liveUrl: 'https://github.com',
      githubUrl: 'https://github.com',
      featured: true,
      image: 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800&q=80',
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
      id: '1',
      title: 'Why Jaspr is the Best Way to Build Web Apps in Dart',
      slug: 'why-jaspr-dart-web',
      excerpt: 'How Google built flutter.dev with Jaspr, and how you can leverage pure Dart for fast, SEO-friendly websites.',
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
