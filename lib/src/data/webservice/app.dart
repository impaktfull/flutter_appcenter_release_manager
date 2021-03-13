import 'package:appcenter_release_manager/src/data/webservice/owner.dart';

class App {
  final String id;
  final String appSecret;
  final String description;
  final String displayName;
  final String name;
  final String os;
  final String platform;
  final String origin;
  final String iconUrl;
  final String createdAt;
  final String updatedAt;
  final String releaseType;
  final Owner? owner;

  App({
    required this.id,
    required this.appSecret,
    required this.description,
    required this.displayName,
    required this.name,
    required this.os,
    required this.platform,
    required this.origin,
    required this.iconUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.releaseType,
    required this.owner,
  });

  factory App.fromJson(Map<String, dynamic> json) => App(
        id: json['id'] as String,
        appSecret: json['app_secret'] as String,
        description: json['description'] as String,
        displayName: json['display_name'] as String,
        name: json['name'] as String,
        os: json['os'] as String,
        platform: json['platform'] as String,
        origin: json['origin'] as String,
        iconUrl: json['icon_url'] as String,
        createdAt: json['created_at'] as String,
        updatedAt: json['updated_at'] as String,
        releaseType: json['release_type'] as String,
        owner: json['owner'] != null
            ? Owner.fromJson(json['owner'] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['app_secret'] = appSecret;
    data['description'] = description;
    data['display_name'] = displayName;
    data['name'] = name;
    data['os'] = os;
    data['platform'] = platform;
    data['origin'] = origin;
    data['icon_url'] = iconUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['release_type'] = releaseType;
    if (owner != null) {
      data['owner'] = owner?.toJson();
    }
    return data;
  }
}
