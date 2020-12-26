import 'dart:io';

import 'package:appcenter_release_manager/src/data/exception/appcenter_release_manager_error.dart';
import 'package:appcenter_release_manager/src/data/webservice/app.dart';
import 'package:appcenter_release_manager/src/data/webservice/owner.dart';
import 'package:appcenter_release_manager/src/data/webservice/release.dart';
import 'package:appcenter_release_manager/src/data/webservice/release_details.dart';
import 'package:appcenter_release_manager/src/data/webservice/user.dart';
import 'package:appcenter_release_manager/src/repo/appcenter_repo.dart';
import 'package:appcenter_release_manager/src/repo/appcenter_repository.dart';
import 'package:appcenter_release_manager/src/webservice/webservice.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class AppCenterReleaseManager {
  static const _channel = MethodChannel('appcenter_release_manager');

  AppCenterRepo _releaseRepo;

  final String apiToken;

  AppCenterReleaseManager({
    @required this.apiToken,
  }) {
    if (apiToken == null) {
      throw AppCenterReleaseManagerError(message: 'apiToken is null');
    } else if (apiToken.isEmpty) {
      throw AppCenterReleaseManagerError(message: 'apiToken is empty');
    }
    _releaseRepo =
        AppCenterRepository(webservice: Webservice(apiToken: apiToken));
  }

  Future<User> getUserDetails() => _releaseRepo.getUserDetails();

  Future<List<Owner>> getAllOrganizations() =>
      _releaseRepo.getAllOrganizations();

  Future<List<App>> getAllApps({String ownerName}) =>
      _releaseRepo.getAllApps(ownerName: ownerName);

  Future<List<Release>> getReleases(String ownerName, String appName) =>
      _releaseRepo.getReleases(ownerName, appName);

  Future<ReleaseDetail> getReleaseDetails(
          String ownerName, String appName, int id) =>
      _releaseRepo.getReleaseDetail(ownerName, appName, id);

  Future<ReleaseDetail> getLatestReleaseDetails(
          String ownerName, String appName) =>
      _releaseRepo.getLatestReleaseDetail(ownerName, appName);

  Future<void> installRelease(ReleaseDetail releaseDetail) async {
    await installReleaseByUrl(releaseDetail.installUrl,
        appName: releaseDetail.appName,
        appVersion: '${releaseDetail.shortVersion} (${releaseDetail.version})');
  }

  Future<void> installReleaseByUrl(String url,
      {String appName, String appVersion}) async {
    if (Platform.isIOS) {
      await launch(url);
      return;
    }
    final data = <String, dynamic>{};
    data['install_url'] = url;
    data['notification_title'] = appName;
    data['notification_description'] = appVersion;

    await _channel.invokeMethod<void>('install_app', data);
  }
}
