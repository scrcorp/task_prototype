class Notice {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final String author;
  final bool isImportant;

  const Notice({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.author,
    required this.isImportant,
  });

  Notice copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    String? author,
    bool? isImportant,
  }) {
    return Notice(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      author: author ?? this.author,
      isImportant: isImportant ?? this.isImportant,
    );
  }
}
