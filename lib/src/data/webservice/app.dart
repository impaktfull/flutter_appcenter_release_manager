import 'package:appcenter_release_manager/src/data/webservice/owner.dart';

class App {
  final String id;
  final String? description;
  final String displayName;
  final String name;
  final String os;
  final String? iconUrl;
  final Owner? owner;

  App({
    required this.id,
    required this.description,
    required this.displayName,
    required this.name,
    required this.os,
    required this.iconUrl,
    required this.owner,
  });

  factory App.fromJson(Map<String, dynamic> json) => App(
        id: json['id'] as String,
        description: json['description'] as String?,
        displayName: json['display_name'] as String,
        name: json['name'] as String,
        os: json['os'] as String,
        iconUrl: json['icon_url'] as String?,
        owner: json['owner'] != null
            ? Owner.fromJson(json['owner'] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['display_name'] = displayName;
    data['name'] = name;
    data['os'] = os;
    data['icon_url'] = iconUrl;
    if (owner != null) {
      data['owner'] = owner?.toJson();
    }
    return data;
  }
}
