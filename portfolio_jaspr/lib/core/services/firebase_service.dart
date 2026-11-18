import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/profile.dart';
import '../../models/education_experience.dart';
import '../../models/portfolio_items.dart';
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

  static const String authEndpoint =
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$apiKey';

  /// Sign in with Firebase email and password via Firebase Auth REST API.
  /// Returns the idToken on success, or throws an exception on error.
  static Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    final response = await http.post(
      Uri.parse(authEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email.trim(),
        'password': password,
        'returnSecureToken': true,
      }),
    );

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200 && data.containsKey('idToken')) {
      return data['idToken'] as String;
    } else {
      final errorMap = data['error'] as Map<String, dynamic>?;
      final message = errorMap?['message']?.toString() ?? 'Invalid credentials';
      throw Exception(message);
    }
  }

  /// Fetch the latest site data from Firestore.
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
    } catch (_) {
      // In case of network timeout or offline mode, fall back safely
      // to the pre-seeded defaultSiteData
    }
    return defaultSiteData;
  }

  /// Save full SiteData to Firestore via REST PATCH.
  static Future<bool> saveSiteData(SiteData data, {String? idToken}) async {
    final fieldsMap = <String, dynamic>{
      'profile': _toFirestoreValue(data.profile.toJson()),
      'education': _toFirestoreValue(data.education.map((e) => e.toJson()).toList()),
      'experience': _toFirestoreValue(data.experience.map((e) => e.toJson()).toList()),
      'projects': _toFirestoreValue(data.projects.map((p) => p.toJson()).toList()),
      'gallery': _toFirestoreValue(data.gallery.map((g) => g.toJson()).toList()),
      'blog': _toFirestoreValue(data.blog.map((b) => b.toJson()).toList()),
    };

    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    if (idToken != null && idToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $idToken';
    }

    final response = await http.patch(
      Uri.parse(firestoreEndpoint),
      headers: headers,
      body: jsonEncode({'fields': fieldsMap}),
    );

    return response.statusCode == 200;
  }

  static dynamic _toFirestoreValue(dynamic val) {
    if (val == null) {
      return {'nullValue': null};
    }
    if (val is bool) {
      return {'booleanValue': val};
    }
    if (val is int) {
      return {'integerValue': val.toString()};
    }
    if (val is double) {
      return {'doubleValue': val};
    }
    if (val is String) {
      return {'stringValue': val};
    }
    if (val is List) {
      return {
        'arrayValue': {
          'values': val.map(_toFirestoreValue).toList(),
        }
      };
    }
    if (val is Map<String, dynamic>) {
      final fields = <String, dynamic>{};
      for (final entry in val.entries) {
        fields[entry.key] = _toFirestoreValue(entry.value);
      }
      return {
        'mapValue': {'fields': fields}
      };
    }
    return {'stringValue': val.toString()};
  }

  static dynamic _extractValue(dynamic val) {
    if (val is! Map<String, dynamic>) return null;
    if (val.containsKey('stringValue')) return val['stringValue'];
    if (val.containsKey('booleanValue')) return val['booleanValue'];
    if (val.containsKey('integerValue')) {
      return int.tryParse(val['integerValue'].toString()) ?? 0;
    }
    if (val.containsKey('doubleValue')) {
      return (val['doubleValue'] as num?)?.toDouble() ?? 0.0;
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
    // 1. Profile
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

    final rawCarousel = (profileMap['carouselTexts'] as List<dynamic>? ?? [])
        .map((t) => t.toString().trim())
        .where((t) => t.isNotEmpty)
        .toList();
    final carouselTexts = (rawCarousel.length >= 2 &&
            !rawCarousel.contains('a Mobile Engineer'))
        ? rawCarousel
        : defaultSiteData.profile.carouselTexts;

    final rawName = profileMap['name']?.toString() ?? '';
    final resolvedName = (rawName.isEmpty || rawName == 'Ilham')
        ? defaultSiteData.profile.name
        : rawName;

    final skills = (profileMap['skills'] as List<dynamic>? ?? [])
        .map((s) => s.toString())
        .toList();

    final certifications = (profileMap['certifications'] as List<dynamic>? ?? [])
        .map((c) => c.toString())
        .toList();

    final profile = Profile(
      name: resolvedName,
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
      skills: skills,
      certifications: certifications,
      stats: statsList.isNotEmpty ? statsList : defaultSiteData.profile.stats,
    );

    // 2. Education - loaded directly from Firebase
    final rawEducation = _extractValue(fields['education']) as List<dynamic>? ?? [];
    final education = rawEducation
        .map((e) => Education.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();

    // 3. Experience - loaded directly from Firebase
    final rawExperience = _extractValue(fields['experience']) as List<dynamic>? ?? [];
    final experience = rawExperience
        .map((e) => Experience.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();

    // 4. Projects - loaded directly from Firebase
    final rawProjects = _extractValue(fields['projects']) as List<dynamic>? ?? [];
    final projects = rawProjects
        .map((p) => Project.fromJson(Map<String, dynamic>.from(p as Map)))
        .toList();

    // 5. Gallery - loaded directly from Firebase with zero dummy fallback
    final rawGallery = _extractValue(fields['gallery']) as List<dynamic>? ?? [];
    final gallery = rawGallery
        .map((g) => GalleryPhoto.fromJson(Map<String, dynamic>.from(g as Map)))
        .toList();

    // 6. Blog
    final rawBlog = _extractValue(fields['blog']) as List<dynamic>? ?? [];
    final blog = rawBlog.isNotEmpty
        ? rawBlog
            .map((b) => BlogPost.fromJson(Map<String, dynamic>.from(b as Map)))
            .toList()
        : defaultSiteData.blog;

    return SiteData(
      profile: profile,
      education: education,
      experience: experience,
      projects: projects,
      gallery: gallery,
      blog: blog,
    );
  }
}
