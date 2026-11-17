import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/profile.dart';
import '../../models/site_data.dart';
import '../../data/portfolio_data.dart';
import '../utils/drive_utils.dart';

class FirebaseService {
  static const String apiKey = 'AIzaSyC4JMX3TvMpBdZ1I3-tIV9ETbDIQ4PHaKY';
  static const String projectId = 'imilham-portfolio';
  static const String collection = 'portfolio';
  static const String docId = 'main';

  static const String firestoreEndpoint =
      'https://firestore.googleapis.com/v1/projects/$projectId/databases/(default)/documents/$collection/$docId?key=$apiKey';

  /// Fetch the latest site and profile data from Firestore, exactly as implemented
  /// in the previous Next.js project.
  static Future<SiteData> fetchSiteData() async {
    try {
      final response = await http
          .get(Uri.parse(firestoreEndpoint))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final fields = json['fields'] as Map<String, dynamic>?;

        if (fields != null) {
          return _parseSiteDataFromFirestore(fields);
        }
      }
    } catch (e) {
      // In case of network timeout or offline mode, fall back safely
      // to the pre-seeded defaultSiteData
    }
    return defaultSiteData;
  }

  static dynamic _extractValue(dynamic val) {
    if (val is! Map<String, dynamic>) return null;
    if (val.containsKey('stringValue')) return val['stringValue'];
    if (val.containsKey('booleanValue')) return val['booleanValue'];
    if (val.containsKey('integerValue')) {
      return int.tryParse(val['integerValue'].toString()) ?? 0;
    }
    if (val.containsKey('arrayValue')) {
      final values = val['arrayValue']['values'] as List<dynamic>? ?? [];
      return values.map(_extractValue).toList();
    }
    if (val.containsKey('mapValue')) {
      final mapFields = val['mapValue']['fields'] as Map<String, dynamic>? ?? {};
      final res = <String, dynamic>{};
      for (final entry in mapFields.entries) {
        res[entry.key] = _extractValue(entry.value);
      }
      return res;
    }
    return null;
  }

  static SiteData _parseSiteDataFromFirestore(Map<String, dynamic> fields) {
    final profileMap = _extractValue(fields['profile']) as Map<String, dynamic>? ?? {};

    final rawHeroPhoto = profileMap['heroPhoto']?.toString() ?? '';
    final resolvedHeroPhoto = getDriveViewUrl(rawHeroPhoto);

    final rawCvUrl = profileMap['cvUrl']?.toString() ?? '';
    final resolvedCvUrl = getDriveDownloadUrl(rawCvUrl);

    final statsList = (profileMap['stats'] as List<dynamic>? ?? [])
        .map((s) => StatItem(
              label: s['label']?.toString() ?? '',
              value: s['value']?.toString() ?? '',
            ))
        .toList();

    final carouselTexts = (profileMap['carouselTexts'] as List<dynamic>? ?? [])
        .map((t) => t.toString())
        .toList();

    final skills = (profileMap['skills'] as List<dynamic>? ?? [])
        .map((s) => s.toString())
        .toList();

    final certifications = (profileMap['certifications'] as List<dynamic>? ?? [])
        .map((c) => c.toString())
        .toList();

    final profile = Profile(
      name: profileMap['name']?.toString() ?? defaultSiteData.profile.name,
      tagline: profileMap['tagline']?.toString() ?? defaultSiteData.profile.tagline,
      bio: profileMap['bio']?.toString() ?? defaultSiteData.profile.bio,
      location: profileMap['location']?.toString() ?? defaultSiteData.profile.location,
      email: profileMap['email']?.toString() ?? defaultSiteData.profile.email,
      github: profileMap['github']?.toString() ?? defaultSiteData.profile.github,
      linkedin: profileMap['linkedin']?.toString() ?? defaultSiteData.profile.linkedin,
      twitter: profileMap['twitter']?.toString() ?? defaultSiteData.profile.twitter,
      heroPhoto: resolvedHeroPhoto.isNotEmpty ? resolvedHeroPhoto : rawHeroPhoto,
      siteTitle: profileMap['siteTitle']?.toString() ?? defaultSiteData.profile.siteTitle,
      cvUrl: resolvedCvUrl.isNotEmpty ? resolvedCvUrl : rawCvUrl,
      enableCarousel: profileMap['enableCarousel'] as bool? ?? true,
      carouselTexts: carouselTexts.isNotEmpty
          ? carouselTexts
          : defaultSiteData.profile.carouselTexts,
      skills: skills.isNotEmpty ? skills : defaultSiteData.profile.skills,
      certifications: certifications.isNotEmpty
          ? certifications
          : defaultSiteData.profile.certifications,
      stats: statsList.isNotEmpty ? statsList : defaultSiteData.profile.stats,
    );

    return SiteData(
      profile: profile,
      education: defaultSiteData.education,
      experience: defaultSiteData.experience,
      projects: defaultSiteData.projects,
      gallery: defaultSiteData.gallery,
      blog: defaultSiteData.blog,
    );
  }
}
