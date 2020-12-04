import 'package:flutter/cupertino.dart';

class Release {
  final String origin;
  final int id;
  final String shortVersion;
  final String version;
  final DateTime uploadedAt;
  final bool enabled;
  final bool isExternalBuild;

  Release({
    @required this.origin,
    @required this.id,
    @required this.shortVersion,
    @required this.version,
    @required this.uploadedAt,
    @required this.enabled,
    @required this.isExternalBuild,
  });

  factory Release.fromJson(Map<String, dynamic> json) => Release(
        origin: json['origin'] as String,
        id: json['id'] as int,
        shortVersion: json['short_version'] as String,
        version: json['version'] as String,
        uploadedAt: DateTime.parse(json['uploaded_at'] as String),
        enabled: json['enabled'] as bool,
        isExternalBuild: json['is_external_build'] as bool,
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['origin'] = origin;
    data['id'] = id;
    data['short_version'] = shortVersion;
    data['version'] = version;
    data['uploaded_at'] = uploadedAt;
    data['enabled'] = enabled;
    data['is_external_build'] = isExternalBuild;
    return data;
  }
}
