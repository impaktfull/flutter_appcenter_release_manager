import 'package:flutter/material.dart';

class ReleaseDetail {
  final String appName;
  final String appDisplayName;
  final String appOs;
  final String appIconUrl;
  final bool isExternalBuild;
  final String origin;
  final int id;
  final String version;
  final String shortVersion;
  final int size;
  final String minOs;
  final String deviceFamily;
  final String bundleIdentifier;
  final String fingerprint;
  final DateTime uploadedAt;
  final String downloadUrl;
  final String installUrl;
  final bool enabled;
  final String provisioningProfileType;
  final String provisioningProfileExpiryDate;
  final String provisioningProfileName;
  final bool isProvisioningProfileSyncing;
  final String releaseNotes;

  const ReleaseDetail({
    @required this.appName,
    @required this.appDisplayName,
    @required this.appOs,
    @required this.appIconUrl,
    @required this.isExternalBuild,
    @required this.origin,
    @required this.id,
    @required this.version,
    @required this.shortVersion,
    @required this.size,
    @required this.minOs,
    @required this.deviceFamily,
    @required this.bundleIdentifier,
    @required this.fingerprint,
    @required this.uploadedAt,
    @required this.downloadUrl,
    @required this.installUrl,
    @required this.enabled,
    @required this.provisioningProfileType,
    @required this.provisioningProfileExpiryDate,
    @required this.provisioningProfileName,
    @required this.isProvisioningProfileSyncing,
    @required this.releaseNotes,
  });

  factory ReleaseDetail.fromJson(Map<String, dynamic> json) => ReleaseDetail(
        appName: json['app_name'] as String,
        appDisplayName: json['app_display_name'] as String,
        appOs: json['app_os'] as String,
        appIconUrl: json['app_icon_url'] as String,
        isExternalBuild: json['is_external_build'] as bool,
        origin: json['origin'] as String,
        id: json['id'] as int,
        version: json['version'] as String,
        shortVersion: json['short_version'] as String,
        size: json['size'] as int,
        minOs: json['min_os'] as String,
        deviceFamily: json['device_family'] as String,
        bundleIdentifier: json['bundle_identifier'] as String,
        fingerprint: json['fingerprint'] as String,
        uploadedAt: DateTime.parse(json['uploaded_at'] as String),
        downloadUrl: json['download_url'] as String,
        installUrl: json['install_url'] as String,
        enabled: json['enabled'] as bool,
        provisioningProfileType: json['provisioning_profile_type'] as String,
        provisioningProfileExpiryDate: json['provisioning_profile_expiry_date'] as String,
        provisioningProfileName: json['provisioning_profile_name'] as String,
        isProvisioningProfileSyncing: json['is_provisioning_profile_syncing'] as bool,
        releaseNotes: json['release_notes'] as String,
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['app_name'] = appName;
    data['app_display_name'] = appDisplayName;
    data['app_os'] = appOs;
    data['app_icon_url'] = appIconUrl;
    data['is_external_build'] = isExternalBuild;
    data['origin'] = origin;
    data['id'] = id;
    data['version'] = version;
    data['short_version'] = shortVersion;
    data['size'] = size;
    data['min_os'] = minOs;
    data['device_family'] = deviceFamily;
    data['bundle_identifier'] = bundleIdentifier;
    data['fingerprint'] = fingerprint;
    data['uploaded_at'] = uploadedAt;
    data['download_url'] = downloadUrl;
    data['install_url'] = installUrl;
    data['enabled'] = enabled;
    data['provisioning_profile_type'] = provisioningProfileType;
    data['provisioning_profile_expiry_date'] = provisioningProfileExpiryDate;
    data['provisioning_profile_name'] = provisioningProfileName;
    data['is_provisioning_profile_syncing'] = isProvisioningProfileSyncing;
    data['release_notes'] = releaseNotes;
    return data;
  }
}
