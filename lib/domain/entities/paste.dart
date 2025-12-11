class Paste {
  final String id;
  final String? title;
  final String content;
  final String language;
  final bool isProtected;
  final DateTime expiresAt;
  final bool burnAfterRead;
  final int views;
  final int? maxViews;
  final List<String> images;

  const Paste({
    required this.id,
    this.title,
    required this.content,
    required this.language,
    required this.isProtected,
    required this.expiresAt,
    required this.burnAfterRead,
    required this.views,
    this.maxViews,
    required this.images,
  });

  factory Paste.fromJson(Map<String, dynamic> json) {
    return Paste(
      id: json['paste_id'],
      title: json['title'],
      content: json['content'],
      language: json['language'],
      isProtected: json['is_protected'],
      expiresAt: DateTime.parse(json['expires_at']),
      burnAfterRead: json['burn_after_read'],
      views: json['views'],
      maxViews: json['max_views'],
      images: List<String>.from(json['images'] ?? []),
    );
  }
}

class PasteCreate {
  final String content;
  final String? title;
  final String language;
  final String? password;
  final int expiresInHours;
  final bool burnAfterRead;
  final int? maxViews;
  final List<String> images;

  PasteCreate({
    required this.content,
    this.title,
    this.language = 'text',
    this.password,
    this.expiresInHours = 24,
    this.burnAfterRead = false,
    this.maxViews,
    this.images = const [],
  });
  
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'title': title,
      'language': language,
      'password': password,
      'expires_in_hours': expiresInHours,
      'burn_after_read': burnAfterRead,
      'max_views': maxViews,
      'images': images,
    };
  }
}
