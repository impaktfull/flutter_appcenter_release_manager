class Owner {
  final String id;
  final String avatarUrl;
  final String displayName;
  final String email;
  final String name;
  final String type;

  Owner({this.id, this.avatarUrl, this.displayName, this.email, this.name, this.type});

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json['id'] as String,
        avatarUrl: json['avatar_url'] as String,
        displayName: json['display_name'] as String,
        email: json['email'] as String,
        name: json['name'] as String,
        type: json['type'] as String,
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['avatar_url'] = avatarUrl;
    data['display_name'] = displayName;
    data['email'] = email;
    data['name'] = name;
    data['type'] = type;
    return data;
  }
}
