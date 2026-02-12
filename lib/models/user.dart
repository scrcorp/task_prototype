class User {
  final String id;
  final String name;
  final String role;
  final String profileImage;
  final String branch;
  final DateTime joinDate;

  const User({
    required this.id,
    required this.name,
    required this.role,
    required this.profileImage,
    required this.branch,
    required this.joinDate,
  });

  User copyWith({
    String? id,
    String? name,
    String? role,
    String? profileImage,
    String? branch,
    DateTime? joinDate,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      profileImage: profileImage ?? this.profileImage,
      branch: branch ?? this.branch,
      joinDate: joinDate ?? this.joinDate,
    );
  }
}
