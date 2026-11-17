/// Utility to parse Google Drive URLs into direct image and download links,
/// exactly matching the implementation in `src/lib/drive.ts` of the original Next.js project.
library;

String getDriveViewUrl(String? url) {
  if (url == null || url.trim().isEmpty) return '';
  final trimmed = url.trim();

  // Match /file/d/{id} or ?id={id} or &id={id}
  final regExp1 = RegExp(r'/file/d/([a-zA-Z0-9_-]+)');
  final regExp2 = RegExp(r'[?&]id=([a-zA-Z0-9_-]+)');
  final match = regExp1.firstMatch(trimmed) ?? regExp2.firstMatch(trimmed);

  if (match != null && match.group(1) != null) {
    final id = match.group(1)!;
    // Direct Google UserContent CDN link or thumbnail endpoint
    return 'https://lh3.googleusercontent.com/d/$id=w1200';
  }
  return trimmed;
}

String getDriveDownloadUrl(String? url) {
  if (url == null || url.trim().isEmpty) return '';
  final trimmed = url.trim();

  final regExp1 = RegExp(r'/file/d/([a-zA-Z0-9_-]+)');
  final regExp2 = RegExp(r'[?&]id=([a-zA-Z0-9_-]+)');
  final match = regExp1.firstMatch(trimmed) ?? regExp2.firstMatch(trimmed);

  if (match != null && match.group(1) != null) {
    final id = match.group(1)!;
    return 'https://drive.google.com/uc?export=download&id=$id';
  }
  return trimmed;
}
