class Profile {
  final String name;
  final String tagline;
  final String bio;
  final String location;
  final String email;
  final String github;
  final String linkedin;
  final String twitter;
  final String heroPhoto;
  final String siteTitle;
  final String cvUrl;
  final bool enableCarousel;
  final List<String> carouselTexts;
  final List<String> skills;
  final List<String> certifications;
  final List<StatItem> stats;

  static const List<String> defaultCarouselRoles = [
    'Senior Mobile Engineer',
    'Flutter Specialist',
    'Entrepreneur',
  ];

  const Profile({
    required this.name,
    required this.tagline,
    required this.bio,
    required this.location,
    required this.email,
    required this.github,
    required this.linkedin,
    required this.twitter,
    required this.heroPhoto,
    required this.siteTitle,
    required this.cvUrl,
    this.enableCarousel = true,
    this.carouselTexts = defaultCarouselRoles,
    this.skills = const [],
    this.certifications = const [],
    this.stats = const [],
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    final parsedCarousel = (json['carouselTexts'] as List<dynamic>?)
            ?.map((e) => e.toString().trim())
            .where((e) => e.isNotEmpty)
            .toList() ??
        [];

    return Profile(
      name: json['name'] as String? ?? '',
      tagline: json['tagline'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      location: json['location'] as String? ?? '',
      email: json['email'] as String? ?? '',
      github: json['github'] as String? ?? '',
      linkedin: json['linkedin'] as String? ?? '',
      twitter: json['twitter'] as String? ?? '',
      heroPhoto: json['heroPhoto'] as String? ?? '',
      siteTitle: json['siteTitle'] as String? ?? '',
      cvUrl: json['cvUrl'] as String? ?? '',
      enableCarousel: json['enableCarousel'] as bool? ?? true,
      carouselTexts: parsedCarousel.length >= 2 ? parsedCarousel : defaultCarouselRoles,
      skills: (json['skills'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      certifications: (json['certifications'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      stats: (json['stats'] as List<dynamic>?)
              ?.map((e) => StatItem.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'tagline': tagline,
        'bio': bio,
        'location': location,
        'email': email,
        'github': github,
        'linkedin': linkedin,
        'twitter': twitter,
        'heroPhoto': heroPhoto,
        'siteTitle': siteTitle,
        'cvUrl': cvUrl,
        'enableCarousel': enableCarousel,
        'carouselTexts': carouselTexts,
        'skills': skills,
        'certifications': certifications,
        'stats': stats.map((s) => s.toJson()).toList(),
      };

  Profile copyWith({
    String? name,
    String? tagline,
    String? bio,
    String? location,
    String? email,
    String? github,
    String? linkedin,
    String? twitter,
    String? heroPhoto,
    String? siteTitle,
    String? cvUrl,
    bool? enableCarousel,
    List<String>? carouselTexts,
    List<String>? skills,
    List<String>? certifications,
    List<StatItem>? stats,
  }) {
    return Profile(
      name: name ?? this.name,
      tagline: tagline ?? this.tagline,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      email: email ?? this.email,
      github: github ?? this.github,
      linkedin: linkedin ?? this.linkedin,
      twitter: twitter ?? this.twitter,
      heroPhoto: heroPhoto ?? this.heroPhoto,
      siteTitle: siteTitle ?? this.siteTitle,
      cvUrl: cvUrl ?? this.cvUrl,
      enableCarousel: enableCarousel ?? this.enableCarousel,
      carouselTexts: carouselTexts ?? this.carouselTexts,
      skills: skills ?? this.skills,
      certifications: certifications ?? this.certifications,
      stats: stats ?? this.stats,
    );
  }
}

class StatItem {
  final String label;
  final String value;

  const StatItem({required this.label, required this.value});

  factory StatItem.fromJson(Map<String, dynamic> json) {
    return StatItem(
      label: json['label'] as String? ?? '',
      value: json['value'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'label': label,
        'value': value,
      };
}
