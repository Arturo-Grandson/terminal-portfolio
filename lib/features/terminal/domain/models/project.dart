class Project {
  final String name;
  final String description;
  final String? url;
  final List<String> technologies;

  const Project({
    required this.name,
    required this.description,
    required this.technologies,
    this.url,
  });

  Project copyWith({
    String? name,
    String? description,
    String? url,
    List<String>? technologies,
  }) {
    return Project(
      name: name ?? this.name,
      description: description ?? this.description,
      url: url ?? this.url,
      technologies: technologies ?? this.technologies,
    );
  }
}
