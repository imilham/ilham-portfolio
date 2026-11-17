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
      profile: Profile.fromJson(json['profile'] as Map<String, dynamic>? ?? {}),
      education: (json['education'] as List<dynamic>?)
              ?.map((e) => Education.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      experience: (json['experience'] as List<dynamic>?)
              ?.map((e) => Experience.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      projects: (json['projects'] as List<dynamic>?)
              ?.map((e) => Project.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      gallery: (json['gallery'] as List<dynamic>?)
              ?.map((e) => GalleryPhoto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      blog: (json['blog'] as List<dynamic>?)
              ?.map((e) => BlogPost.fromJson(e as Map<String, dynamic>))
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
}
