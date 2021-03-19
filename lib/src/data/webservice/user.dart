class User {
  final String id;
  final String displayName;
  final String email;
  final String name;
  final String? avatarUrl;
  final bool canChangePassword;
  final DateTime? createdAt;
  final String origin;

  User({
    required this.id,
    required this.displayName,
    required this.email,
    required this.name,
    required this.avatarUrl,
    required this.canChangePassword,
    required this.createdAt,
    required this.origin,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as String,
        displayName: json['display_name'] as String,
        email: json['email'] as String,
        name: json['name'] as String,
        avatarUrl: json['avatar_url'] as String?,
        canChangePassword: json['can_change_password'] as bool,
        createdAt: DateTime.parse(json['created_at'] as String),
        origin: json['origin'] as String,
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['display_name'] = displayName;
    data['email'] = email;
    data['name'] = name;
    data['avatar_url'] = avatarUrl;
    data['can_change_password'] = canChangePassword;
    data['created_at'] = createdAt?.toIso8601String();
    data['origin'] = origin;
    return data;
  }
}
