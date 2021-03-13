import 'package:appcenter_release_manager/appcenter_release_manager.dart';
import 'package:appcenter_release_manager/src/data/webservice/app.dart';
import 'package:appcenter_release_manager/src/data/webservice/owner.dart';
import 'package:appcenter_release_manager/src/data/webservice/release.dart';
import 'package:appcenter_release_manager/src/data/webservice/release_details.dart';
import 'package:appcenter_release_manager/src/data/webservice/user.dart';
import 'package:appcenter_release_manager/src/repo/appcenter_repo.dart';
import 'package:appcenter_release_manager/src/webservice/webservice.dart';

class AppCenterRepository extends AppCenterRepo {
  final Webservice webservice;

  AppCenterRepository({
    required this.webservice,
  });

  @override
  Future<User> getUserDetails() async {
    final data = await webservice.get<Map<dynamic, dynamic>>('/v0.1/user');
    return User.fromJson(data as Map<String, dynamic>);
  }

  @override
  Future<List<Owner>> getAllOrganizations() async {
    final data = await webservice.get<List<dynamic>>('/v0.1/orgs');
    return data.map((dynamic e) => Owner.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<App>> getAllApps({String? ownerName}) async {
    List<dynamic> data;
    if (ownerName == null) {
      data = await webservice.get<List<dynamic>>('/v0.1/apps');
    } else {
      data = await webservice.get<List<dynamic>>('/v0.1/orgs/$ownerName/apps');
    }
    return data.map((dynamic e) => App.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<Release>> getReleases(String ownerName, String appName) async {
    final data = await webservice.get<List<dynamic>>('/v0.1/apps/$ownerName/$appName/releases');
    return data.map((dynamic e) => Release.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<ReleaseDetail> getReleaseDetail(String ownerName, String appName, int id) async {
    final data = await webservice.get<Map<String, dynamic>>('/v0.1/apps/$ownerName/$appName/releases/$id');
    return ReleaseDetail.fromJson(data);
  }

  @override
  Future<ReleaseDetail?> getLatestReleaseDetail(String ownerName, String appName) async {
    final data = await webservice.get<List<dynamic>>('/v0.1/apps/$ownerName/$appName/recent_releases');
    final list = data.map((dynamic e) => Release.fromJson(e as Map<String, dynamic>)).toList();
    if (list.isEmpty) return null;
    list
      ..removeWhere((element) => element.uploadedAt == null)
      ..sort((a, b) {
        if (a.uploadedAt == null) return 0;
        if (b.uploadedAt == null) return 0;
        return b.uploadedAt!.compareTo(a.uploadedAt!);
      });
    return getReleaseDetail(ownerName, appName, list.first.id);
  }
}
