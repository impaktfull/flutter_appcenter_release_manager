# AppCenter Release Manager

[![pub package](https://img.shields.io/pub/v/appcenter_release_manager.svg)](https://pub.dartlang.org/packages/appcenter_release_manager)
[![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

Download appcenter updates straight from your iOS or Android app.

### Use the predefined UI with the AppcenterReleaseManagerLatestReleases widget
Api Token should have read access only
```dart
  AppcenterReleaseManagerLatestReleases(
    apiToken: 'your-api-token',
    ownerName: 'your-owner-name',
    appName: 'your-app-name',
  ),
```

### Use the manager to create your custom ui. Should be used as a repository/service
Api Token should have read access only
```dart
AppCenterReleaseManager(
  apiToken: 'your-api-token',
)
```

### Install by url or release details:
Api Token should have read access only
```dart
final details = await AppCenterReleaseManager(apiToken: '').getLatestReleaseDetails('owner_name','app_name');
AppCenterReleaseManager(apiToken: '').installRelease(details, openAndroidInstallScreen: true, keepAndroidNotification: false);
```

Or by url
Api Token should have read access only
```dart
final details = await AppCenterReleaseManager(apiToken: '').getLatestReleaseDetails('owner_name','app_name');
AppCenterReleaseManager(apiToken: '').installReleaseByUrl(details.installUrl, appName: 'your-app-name', appVersion: 'your-version', openAndroidInstallScreen: true, keepAndroidNotification: false); //appName & appVersion & openAndroidInstallScreen & keepAndroidNotification will be used in the notification on android. On iOS this is never used
```

#### Install Options

`openAndroidInstallScreen` -> On Android, this will open the install screen after the download is finished. On iOS this is never used

`keepAndroidNotification` -> On Android, this will keep the notification after the download is finished. On iOS this is never used
If you use openAndroidInstallScreen: false -> keepAndroidNotification will automatically be set to true

### Full access
If you also want to splits everything up by owner you need to provide a full access api token

### Other available methods for the AppCenterReleaseManager:
Api Token should have read access only
```dart
AppCenterReleaseManager(apiToken: '').getUserDetails(); //global api token only

AppCenterReleaseManager(apiToken: '').getAllOrganizations(); //global api token only

AppCenterReleaseManager(apiToken: '').getAllApps(); //global api token only

AppCenterReleaseManager(apiToken: '').getAllApps(ownerName: 'owner_name'); //global api token only

AppCenterReleaseManager(apiToken: '').getReleases('owner_name','app_name'); //global/app api token only

AppCenterReleaseManager(apiToken: '').getReleaseDetails('owner_name','app_name', 'id'); //global/app api token only

AppCenterReleaseManager(apiToken: '').getLatestReleaseDetails('owner_name','app_name'); //global/app api token only
```

### Android Production:

This package automaticly adds an extra permission to install apps from Android 8 & above.

```xml
    <uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />
```

For most cases you don't want this permission in Production. To remove this. Add the following lines to the AndroidManifest.xml for the flavour/buildtype where you don't want this permission

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    package="your-package-name">

    <uses-permission
        android:name="android.permission.REQUEST_INSTALL_PACKAGES"
        tools:node="remove" />

</manifest>
```

In most cases you will place this in

`/android/app/src/release/AndroidManifest.xml`

But if you are using a flavour like `prod`, `alpha`, `beta` it will probably only be added here:

`/android/app/src/prod/AndroidManifest.xml`

This will make sure that the permission is only removed in `prod` so you can still install updates in `beta` & `alpha`
