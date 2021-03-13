import 'package:appcenter_release_manager/appcenter_release_manager.dart';
import 'package:appcenter_release_manager/src/data/webservice/app.dart';
import 'package:appcenter_release_manager/src/data/webservice/owner.dart';
import 'package:appcenter_release_manager/src/data/webservice/release_details.dart';
import 'package:appcenter_release_manager/src/data/webservice/user.dart';

abstract class AppCenterRepo {
  Future<User> getUserDetails();

  Future<List<Owner>> getAllOrganizations();

  Future<List<App>> getAllApps({String? ownerName});

  Future<List<Release>> getReleases(String ownerName, String appName);

  Future<ReleaseDetail> getReleaseDetail(
      String ownerName, String appName, int id);

  Future<ReleaseDetail?> getLatestReleaseDetail(
      String ownerName, String appName);
}
