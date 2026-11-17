import 'profile.dart';
import 'education_experience.dart';
import 'portfolio_items.dart';

class SiteData {
  final Profile profile;
  final List<Education> education;
  final List<Experience> experience;
  final List<Project> projects;
  final List<GalleryPhoto> gallery;
  final List<BlogPost> blog;

  const SiteData({
    required this.profile,
    required this.education,
    required this.experience,
    required this.projects,
    required this.gallery,
    required this.blog,
  });

  factory SiteData.fromJson(Map<String, dynamic> json) {
    return SiteData(
      profile: Profile.fromJson(
        json['profile'] != null
            ? Map<String, dynamic>.from(json['profile'] as Map)
            : {},
      ),
      education: (json['education'] as List<dynamic>?)
              ?.map((e) => Education.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          [],
      experience: (json['experience'] as List<dynamic>?)
              ?.map((e) => Experience.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          [],
      projects: (json['projects'] as List<dynamic>?)
              ?.map((e) => Project.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          [],
      gallery: (json['gallery'] as List<dynamic>?)
              ?.map((e) => GalleryPhoto.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          [],
      blog: (json['blog'] as List<dynamic>?)
              ?.map((e) => BlogPost.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'profile': profile.toJson(),
        'education': education.map((e) => e.toJson()).toList(),
        'experience': experience.map((e) => e.toJson()).toList(),
        'projects': projects.map((e) => e.toJson()).toList(),
        'gallery': gallery.map((e) => e.toJson()).toList(),
        'blog': blog.map((e) => e.toJson()).toList(),
      };

  SiteData copyWith({
    Profile? profile,
    List<Education>? education,
    List<Experience>? experience,
    List<Project>? projects,
    List<GalleryPhoto>? gallery,
    List<BlogPost>? blog,
  }) {
    return SiteData(
      profile: profile ?? this.profile,
      education: education ?? this.education,
      experience: experience ?? this.experience,
      projects: projects ?? this.projects,
      gallery: gallery ?? this.gallery,
      blog: blog ?? this.blog,
    );
  }
}
