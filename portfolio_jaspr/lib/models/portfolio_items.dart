class Project {
  final String id;
  final String title;
  final String description;
  final List<String> tags;
  final String liveUrl;
  final String githubUrl;
  final bool featured;
  final String image;

  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.tags,
    required this.liveUrl,
    required this.githubUrl,
    this.featured = false,
    required this.image,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      liveUrl: json['liveUrl'] as String? ?? '',
      githubUrl: json['githubUrl'] as String? ?? '',
      featured: json['featured'] as bool? ?? false,
      image: json['image'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'tags': tags,
        'liveUrl': liveUrl,
        'githubUrl': githubUrl,
        'featured': featured,
        'image': image,
      };
}

class GalleryPhoto {
  final String id;
  final String url;
  final String caption;
  final String category;

  const GalleryPhoto({
    required this.id,
    required this.url,
    required this.caption,
    required this.category,
  });

  factory GalleryPhoto.fromJson(Map<String, dynamic> json) {
    return GalleryPhoto(
      id: json['id'] as String? ?? '',
      url: json['url'] as String? ?? '',
      caption: json['caption'] as String? ?? '',
      category: json['category'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'caption': caption,
        'category': category,
      };
}

class BlogPost {
  final String id;
  final String title;
  final String slug;
  final String excerpt;
  final String content;
  final List<String> tags;
  final String coverImage;
  final String publishedAt;
  final bool published;

  const BlogPost({
    required this.id,
    required this.title,
    required this.slug,
    required this.excerpt,
    required this.content,
    required this.tags,
    required this.coverImage,
    required this.publishedAt,
    this.published = true,
  });

  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      excerpt: json['excerpt'] as String? ?? '',
      content: json['content'] as String? ?? '',
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      coverImage: json['coverImage'] as String? ?? '',
      publishedAt: json['publishedAt'] as String? ?? '',
      published: json['published'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'slug': slug,
        'excerpt': excerpt,
        'content': content,
        'tags': tags,
        'coverImage': coverImage,
        'publishedAt': publishedAt,
        'published': published,
      };
}
