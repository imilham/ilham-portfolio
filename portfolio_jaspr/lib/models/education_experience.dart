class Education {
  final String id;
  final String degree;
  final String school;
  final String year;
  final String description;

  const Education({
    required this.id,
    required this.degree,
    required this.school,
    required this.year,
    required this.description,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      id: json['id'] as String? ?? '',
      degree: json['degree'] as String? ?? '',
      school: json['school'] as String? ?? '',
      year: json['year'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'degree': degree,
        'school': school,
        'year': year,
        'description': description,
      };

  Education copyWith({
    String? id,
    String? degree,
    String? school,
    String? year,
    String? description,
  }) {
    return Education(
      id: id ?? this.id,
      degree: degree ?? this.degree,
      school: school ?? this.school,
      year: year ?? this.year,
      description: description ?? this.description,
    );
  }
}

class Experience {
  final String id;
  final String role;
  final String company;
  final String period;
  final String description;
  final List<String> technologies;

  const Experience({
    required this.id,
    required this.role,
    required this.company,
    required this.period,
    required this.description,
    required this.technologies,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['id'] as String? ?? '',
      role: json['role'] as String? ?? '',
      company: json['company'] as String? ?? '',
      period: json['period'] as String? ?? '',
      description: json['description'] as String? ?? '',
      technologies: (json['technologies'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'role': role,
        'company': company,
        'period': period,
        'description': description,
        'technologies': technologies,
      };

  Experience copyWith({
    String? id,
    String? role,
    String? company,
    String? period,
    String? description,
    List<String>? technologies,
  }) {
    return Experience(
      id: id ?? this.id,
      role: role ?? this.role,
      company: company ?? this.company,
      period: period ?? this.period,
      description: description ?? this.description,
      technologies: technologies ?? this.technologies,
    );
  }
}
